---
layout: posts
title: Dynamic scheduling for faster remote builds
authors:
  - jmmv
  - jin
---

The recently-released [Bazel 0.21](https://blog.bazel.build/2018/12/19/bazel-0.21.html) delivers a new feature that can make your remote builds faster by making use of local resources where possible. Prior to this release, this was already doable to some extent by using manual strategy definitions, but this new feature takes all manual decisions out of the picture.

Let's dive in!

## Background

Bazel's execution phase runs a bunch of [actions](https://docs.bazel.build/versions/master/skylark/rules.html#actions) in order to complete your build. The way these actions run is defined by **strategies**. Each action has a **mnemonic** that identifies its class (for example, `CppLink` or `Genrule`), and each mnemonic is connected to one strategy. The strategy is responsible for scheduling and running the action's commands. The main strategies are: 

*   `standalone` for unsandboxed execution,
*   `sandboxed` for sandboxed execution on the local machine,
*   `worker` for execution on a persistent worker on the local machine, and
*   `remote` for execution on a remote service like RBE.

Action mnemonics are statically mapped to strategies via command-line flags. When Bazel encounters an action, it consults such mappings to determine which strategy to use for the action, and runs the action that way. This results in bimodal execution: when remote execution is enabled, Bazel uses the `remote` strategy for all actions and, when it is disabled (the default), Bazel uses the `sandboxed` strategy.

## The problem with remote execution

Unfortunately, in the case of remote execution, sending *all* actions through the `remote` strategy is inefficient. Each remote action comes with a cost: there is the overhead of the RPCs to contact with the remote service and there is also the more-significant overhead of uploading inputs and downloading outputs (even if we can [maybe optimize the latter](https://docs.google.com/document/d/11m5AkWjigMgo9wplqB8zTdDcHoMLEFOSH0MdBNCBYOE/edit)). As a result, blindly running all actions remotely can be (and often is) detrimental to performance.

You'd think that this is not a big deal though---if remote execution offers sufficient parallelism, the fact that each action has higher latency is compensated by the fact that we have a much higher throughput than what you'd ever get with pure local execution. And you'd think right---this has been the case for a long time, at least within Google, because the overheads of remote execution were not too high due to strong network connectivity guarantees.

But this model breaks down when the cost of remote execution is non-trivial. For example, imagine if a link action that takes about 30 seconds on the local machine requires up to 10 minutes on a remote machine (and, yes, we have painfully observed this due to file transfer artifacts). And notice that I said *link* action---linking happens in every single build, and linking is almost-certainly in the critical path… so imagine what happens to incremental builds. The introduced delay kills the edit/build/test cycle, so some users affected by this problem have rightfully objected to using remote execution.

Some users had papered over this problem by configuring certain mnemonics to run locally but this approach doesn't scale: unless you have time to dedicate to engineering productivity (and not everyone has this privilege), it will be difficult to set things up and maintain them over time to keep builds fast.

## The bright future

Fortunately, there is a solution to this problem. Enter the new dynamic scheduler in Bazel 0.22 and its new `dynamic` strategy.

When the dynamic scheduler is enabled in combination with remote execution, Bazel sends all actions to the remote execution service… but also runs a subset of those actions locally as permitted by the limits expressed via `--local_cpu_resources` and `--local_ram_resources`. Bazel then monitors which of the two instances of the same action completes fastest, takes its result, and cancels the other one.

This approach yields the best of both worlds: for clean builds where we expect Bazel to have to build all actions (regardless of remote cache hits or not), Bazel can take advantage of the massive throughput of remote execution. But for incremental builds that are bottlenecked on individual actions, running those actions locally avoids all overheads of remote execution.

## Neat! How can I use this feature?

There are a couple of prerequisites to use the dynamic spawn scheduler feature:

*   You’ve set up remote execution (via something like RBE).
*   The remote executors and the machine on which you run Bazel use the same operating system and machine architecture. (Tools compiled for the host also need to be executable on the remote executors.)

If your setup satisfies the above, all you have to do is specify `--experimental_spawn_scheduler` on your next build. Just make sure to pass this new flag after all others.

## Let's look at some numbers

We have measured the behavior of the dynamic scheduler on a large iOS app on three  Macs with different local performance characteristics, and also a [large Android app](https://github.com/jin/android-projects#big_connected) on a Linux workstation [using RBE](https://gist.github.com/jin/1fc2543acef7cdbd5618b08579d7210c) for the remote execution backend. The specific details of the build and the machines is not relevant.

Here are the results for clean build times:

App type | Machine | Local only | Remote only | Dynamic
--- | --- | ---: | ---: | ---:
Android | HP Z440, 12-core | 53s | 20s ↓ | 21s ↓
iOS | iMac Pro 2018, 18-core | 2390s | 1287s ↓ | 245s ↓↓
iOS | Mac Pro 2013, 6-core | 2449s | 1290s ↓ | 303s ↓↓
iOS | MacBook Pro 2015, 4-core | 2999s | 1299s ↓ | 648s ↓↓

And here are the results for incremental build times after modifying a single leaf source file. For iOS, these builds account for compilation of a single file and linking, bundling and signing for the whole app. For Android, these builds account for Java compilation, dexing, resource processing and APK packing:

App type | Machine | Local only | Remote only | Dynamic
--- | --- | ---: | ---: | ---:
Android (Java change) | HP Z440, 12-core | 9s | 60s ↑ | 10s ≈
Android (Manifest change) | HP Z440, 12-core | 3s | 29s ↑ | 4s ≈
iOS | iMac Pro 2018, 18-core | 34s | 414s ↑ | 32s ≈
iOS | Mac Pro 2013, 6-core | 39s | 414s ↑ | 36s ≈
iOS | MacBook Pro 2015, 4-core | 39s | 450s ↑ | 36s ≈

As you can see, the remote-only configuration gave us slightly better results than the local-only configuration for clean builds, but the remote-only configuration became unacceptably slow for incremental builds. As expected, though, dynamic execution wins heads-down in all cases: clean builds are many times faster than they are with local or remote execution alone, and incremental builds are essentially the same.

We expect the speedup to be more prominent as builds get larger, as seen in the difference between the iOS and Android builds.

## Future work and credits

There still are some problems to be resolved, of course. The major one is that local workers do not support cancellations ([#614](https://github.com/bazelbuild/bazel/issues/614]), and this can result in a high build timing variance depending on how the actions are scheduled. Other minor issues include: an artificial delay before running actions locally ([#7327](https://github.com/bazelbuild/bazel/issues/7327)) and making sure remote caches are populated even when we cancel actions ([#7328](https://github.com/bazelbuild/bazel/issues/7328)).

As a historical note, [@philwo](https://github.com/philwo/) originally implemented the dynamic spawn scheduler as a Google-internal module. The reason was simplicity because the code needed to directly interact with the Forge module. [@jin](https://github.com/jin/) later worked on generalizing the code to support both Forge and RBE and is who brought you this feature in Bazel 0.21. I, [@jmmv](https://julio.meroh.net/), am only the messenger and a performance tester.

Please give this a try and [let us know](https://groups.google.com/forum/#!forum/bazel-discuss) how it goes!
