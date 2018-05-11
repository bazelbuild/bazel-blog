---
layout: posts
title: Preliminary sandboxfs support and performance results
authors:
  - jmmv
---

[Back in August of 2017]({% post_url 2017-08-25-introducing-sandboxfs %}), we
introduced sandboxfs: a project to improve the performance and correctness of
builds that have action sandboxing enabled. Today, after months of work to
stabilize the codebase, we are happy to announce that preliminary support for
sandboxfs is available in Bazel HEAD after April 13th!

This post presents the performance measurements we have gotten so far when using
sandboxfs. As these metrics look promising, the true goal of this post is a
**call for action**: we know a bunch of you have previously expressed that
sandboxing was unusable due to its overhead so we want to know if sandboxfs
makes things better for you.

## Sandboxing basics

Before delving into the details, let's quickly recap what action sandboxing is
and how sandboxfs is supposed to benefit it. (Refer to [the previous post]({%
post_url 2017-08-25-introducing-sandboxfs %}) for a much more detailed
explanation.)

**Sandboxing** is Bazel's ability to isolate the execution of each build action
(think "compiler invocation") from the rest of the system. This feature
restricts what actions can do so that they only have access to the tools and
inputs they declare and so that they are only able to write the outputs they
promised. In this way, we ensure that the build graph doesn't have hidden
dependencies that could poison the reproducibility of the build.

More specifically, Bazel constructs an **execroot** for each action, which acts
as the action's work directory at execution time. The execroot contains all
input files to the action and serves as the container for any generated outputs.
Bazel then uses an operating system-provided technique—containers on Linux and
`sandbox-exec` on macOS—to constrain the action within the execroot. It is worth
noting that the preparation of the disk layout and the actual sandboxing are
orthogonal.

Traditionally, Bazel has been creating the execroot using symlinks, thus
creation scales linearly with the number of inputs. Creating all these symlinks
is costly for actions with thousands of inputs and unfortunately these are not
uncommon. This is where sandboxfs is supposed to help.

**sandboxfs** is a FUSE file system that exposes an arbitrary view of the
underlying file system and does so without time penalties. Bazel can then use
sandboxfs to generate the execroot "instantaneously" for each action, avoiding
the cost of issuing thousands of system calls. The downside is that all further
I/O within the execroot is slower due to FUSE overhead. We hypothesized that
this was a tradeoff with potentials for time savings and we are at a point where
we can prove it. Let's see how this has played out so far.

## Performance results

The experiments below were run under the following build machines:

*   MacBook Pro 2016: Intel Core i7-6567U CPU @ 3.30GHz, 2 cores, 16GB RAM, SSD.
*   Mac Pro 2013: Intel Xeon CPU E5-1650 v2 @ 3.50GHz, 6 cores, 32GB RAM, SSD.
*   Linux workstation: Intel Xeon CPU E5-2699 v3 @ 2.30GHz, 6 cores, 32GB RAM,
    SSD.

And here are the specific build times obtained from a variety of different
targets. All these builds were clean builds, and each was run 10 times and
averaged to minimize noise:

| ID | Target | Machine | No sandbox | Symlinked sandbox | sandboxfs sandbox |
| --- | --- | --- | --- | --- | --- |
| **BL** | Bazel | MacBook Pro 2017 | 581 sec | 621 sec (+6%) | 612 sec (+5%) |
| **BW** | Bazel | Mac Pro 2013 | 247 sec | 265 sec (+7%) | 250 sec (+1%) |
| **IW** | iOS app | Mac Pro 2013 | 1235 sec | 4572 sec (+270%) | 1922 sec (+55%) |
| **CW** | C++/Go library | Linux workstation | 1175 sec | 1318 sec (+12%) | 828 sec (-30%) |

Let's ignore the strange **CW** build results for a moment.

As you can see from all builds, sandboxfs-based builds are strictly better than
symlinks-based builds. The cost of sandboxing, however, varies widely depending
on what's being built and on what machine. For **BL** and **BW**, the cost of
sandboxing is small enough to think that using sandboxing unconditionally is
possible. For **IW**, however, the cost of sandboxing is significant in either
case. That said, for **IW** we see the massive time savings of the
sandboxfs-based approach, and this (slow iOS builds) is the specific case we set
to fix at the beginning of the sandboxfs project.

These results are optimistic but we have also observed cases where sandboxfs
builds are slower than symlinked builds. I wasn't able to reproduce those when
preparing this blog post but be aware that it's entirely possible for you to
observe slower builds when using sandboxfs. We have some work to do before we
can gain more confidence on this.

Now, what's up with **CW**? Note that sandboxfs-based builds are *faster* than
without sandboxing. This makes little sense: how can it possibly be that doing
*more* work results in a faster build? We don't really know yet, but the
measurements were pretty conclusive. One possible explanation is that using
sandboxfs to expose the sources of the actions somehow reduces contention on
srcfsd (the other FUSE file system we use in our builds, which exposes the
monolithic Google repository) and makes its overall behavior faster.

## Usage instructions

Convinced that you should give this a try? Excellent. Use the following steps to
install sandboxfs and perform a Bazel build with it. Be aware that due to the
current status of sandboxfs (no formal releases), these may change at any time.

1.  Ensure you are using a Bazel build newer than April 13th or wait for the
    future 0.13.x release series.

1.  Download and install sandboxfs so that the `sandboxfs` binary ends up in
    your `PATH`. There currently are no formal releases for this project so you
    will have to do a [HEAD build from
    GitHub](https://github.com/bazelbuild/sandboxfs/blob/master/INSTALL.md)
    using Bazel.

1.  (macOS-only) [Install OSXFUSE](https://osxfuse.github.io/).

1.  (macOS-only) Run `sudo sysctl -w
    vfs.generic.osxfuse.tunables.allow_other=1`. You will need to do this after
    installation and after every reboot. This is unfortunately [necessary to
    ensure core macOS system services
    work](http://julio.meroh.net/2017/10/fighting-execs-sandboxfs-macos.html)
    through sandboxfs.

1.  Run your favorite Bazel build with `--experimental_use_sandboxfs`.

That's it!

If you see `local` instead of `darwin-sandbox` or `linux-sandbox` as an
annotation for the actions that are executed, this may mean that sandboxing is
disabled. Pass `--genrule_strategy=sandboxed --spawn_strategy=sandboxed` to
enable it.

## Next steps

We cannot yet recommend using sandboxfs by default nor we can't convince you yet
to enable sandboxing unconditionally due to its non-zero cost. But the current
status may be sufficient for you to enable sandboxing in some cases
(*especially* during release builds if you are not doing so yet).

Here are some things we are planning to look into:

*   Further investigate what can be optimized within sandboxfs. Some preliminary
    profiling routinely points at the CPU being spent in the Go runtime so it's
    unclear if fixes will be easy/possible. (Due to personal curiosity, I've
    been prototyping a reimplementation in Rust and have a feeling that it can
    significantly cut down CPU usage in sandboxfs.)

*   We know that symlinked sandboxing is faster than sandboxfs in some cases.
    Investigate what the cutoff point is (as a number of action inputs, or
    something else) and implement a mode where we only use sandboxfs in the
    cases where we know it will help most.

*   Improve the protocol between sandboxfs and Bazel so that we are confident in
    making a first release of sandboxfs for easier distribution. If we had
    binary releases, we could even bundle OSXFUSE within the image we ship so
    that you didn't need to mess with `sysctl`, for example.

*   Pie-in-the-sky idea: reimplement sandboxfs as a kernel module. This is
    really the only way to make sandboxing overhead minimal, but is also the
    hardest to maintain. On the bright side, note that sandboxfs (excluding
    tests) is only about 1200 lines and that the tests and Bazel integration are
    fully reusable for any implementation—this rewrite may not be as daunting as
    it sounds.

We know that many of you have previously raised the bad performance of
sandboxing as a blocker for enabling it. We are very interested in knowing what
kind of impact this has on your builds so that we can assess how important it is
to continue working on this. Please give the instructions above a try and let us
know how it goes! And also, let us know if you want to contribute!
