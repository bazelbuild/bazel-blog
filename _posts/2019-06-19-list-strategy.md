---
layout: posts
title: "Automatic execution strategy selection in Bazel 0.27"
authors:
  - ishikhman
---
**tl;dr**: Exciting news! After [0.27](https://blog.bazel.build/2019/06/17/bazel-0.27.0.html) release Bazel can *auto select* a suitable execution strategy, 
eliminating the need for manual configuration via command line flags in most cases.

When Bazel executes commands that are a part of the build, such as compiler and linker invocations, test runs etc., 
it has a choice on how to execute those commands (also called actions): locally, remotely, in a sandbox, and so on. 
This is controlled by [execution strategies](https://docs.bazel.build/versions/master/user-manual.html#strategy-options). Starting with 0.27 release, we implemented a feature in Bazel that will 
allow it to auto select a suitable execution strategy, eliminating the need for manual configuration via command line 
flags in most cases; and even in cases when customization and strategy enforcement is needed, it is still fully possible and has become much simpler.

## Before Bazel 0.27

It was possible to configure Bazel's [execution strategy](https://docs.bazel.build/versions/master/user-manual.html#strategy-options) for a build via flags `--spawn_strategy=`, `--strategy=Mnemonic=` and `--strategy_regexp=Regex=`. 
This mechanism was quite powerful and widely used, but had some drawbacks:

- Bazel's defaults did not account for remote execution at all, therefore we had to make sure to set the execution strategy for every mnemonic manually.

- Starlark rules providing a persistent worker had to ship a .bazelrc file that sets `--strategy=Mnemonic=worker` (e.g. look at [rules_scala](https://github.com/bazelbuild/rules_scala#getting-started), where `--strategy=Scalac=worker` is required in order to run it with a persistent worker). 

- Bazel had hardcoded defaults for native action mnemonics. For example, Bazel would have used sandboxing (if it's available) for all actions by default but at the same time had a hardcoded default to use persistent workers for Java compilation actions.

- To configure fallback strategy one had to provide additional flag `--remote_local_fallback_strategy=`.

### Example

> Let's configure a build to run remotely and fallback onto `local` strategy in case remote execution is not possible. The configuration would be something like:
> 
``` 
$ bazel build
 --spawn_strategy=remote
 --strategy=Javac=remote
 --strategy=Closure=remote
 --strategy=Genrule=remote
 --remote_local_fallback_strategy=local
 ... 
```

## After Bazel 0.27
- Bazel now *auto-detects* the execution strategy, if no strategy flag is provided.  
If none of the strategy flags was used, bazel will generate a default list of strategies `remote,worker,sandboxed,local` and, for every action it wants to execute, will pick up the first strategy that can execute it.

- The user can pass a comma-separated list of strategies to the above mentioned flags: `--spawn_strategy=remote,worker,linux-sandbox`.  
Each strategy now knows whether it can execute a given action.
For any action that it wants to execute, Bazel just picks the first strategy from the given list that can execute the action. 

- If an action cannot be executed with any of the given strategies, the build will fail.  
If any of the strategy flags is provided, then Bazel will use ONLY those strategies that are listed there. 
Which means that `--spawn_strategy=remote` will NOT fallback to a `sandboxed` strategy or to any other strategy in case remote action failed or is not possible at all.
Moreover, `--remote_local_fallback_strategy=local` is now deprecated and made no-op. 

### Why is it better?
- Now you can control your execution strategy and have your build fail if any non-sandboxable or non-remotable action sneaks in! 
More reproducibility and safety for your builds!
- The strategies no longer do their own custom fallback, simplifying the code and unifying the behavior.
- You might even completely forget about strategies configurations if the default behavior satisfies your needs.

### Example

> This is how the previous example will look like now:
>
``` 
$ bazel build
 --spawn_strategy=remote,local
 ... 
```
>
> And if a custom strategy for Java rules is required, we can still add `--strategy=Javac=`:
>
```
$ bazel build
 --spawn_strategy=remote,local
 --strategy=Javac=worker
 ...
```
>
> In this case, Java rules will be executed using a persistent *worker*, everything else will be executed *remotely* or *locally* (if remote is not possible).
> Isn't it much shorter and simpler?


## How to use it

- You want a build to be executed properly with minimal configuration: don't set any strategy flags and Bazel will try to do the best automatically. Bazel will use remote execution if it's available, otherwise persistent workers, otherwise sandboxed execution, otherwise non-sandboxed execution.
- You want the best sandboxed build on your Linux machine and no automatic fallback to symlink-only sandboxing, non-sandboxed execution and no persistent workers: `--spawn_strategy=linux-sandbox`.
- You want persistent workers for actions that support it, but otherwise only sandboxed execution: `--spawn_strategy=worker,sandboxed`.
- You want to ensure everything runs remotely: `--spawn_strategy=remote`. Be careful, this configuration will cause a build failure in case bazel finds any action that cannot be executed remotely.

### How to migrate
You would know that you need to migrate if you see the following error:
 
```
ERROR: No usable spawn strategy found for spawn with mnemonic %Mnemonic%. Are your --spawn_strategy or --strategy flags too strict?
```

The general advice here would be to remove any `--spawn_strategy`, `--strategy`, `--remote_local_fallback_strategy=` or `--strategy_regexp=Regex=` flags that you might be setting manually or via a .bazelrc file, this will allow bazel to automatically detect suitable execution strategy.
In case this is not working for you, review the above [how-to-use section](#how-to-use-it) for ideas. 

### Contact us
Note that the change was made behind the [incompatible flag](https://github.com/bazelbuild/bazel/issues/7480), so please ping us in case of any difficulties.
