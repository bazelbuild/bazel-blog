---
layout: posts
title: "Automatic execution strategy selection in Bazel 0.27"
authors:
  - ishikhman
---
**tl;dr**: Exciting news! After 0.27 release Bazel will *auto select* a suitable execution strategy if none is provided. Customization and strategy enforcement will still be possible and will be much easier to configure.

## Before Bazel 0.27

It was possible to configure Bazel's execution strategy for a build via flags `--spawn_strategy=`, `--strategy=Mnemonic=` and `--strategy_regexp=Regex=`. This mechanism was quite powerful and widely used, but had some drawbacks:

- Bazel's defaults did not account for remote execution at all, therefore we had to make sure to set the execution strategy for every mnemonic manually.

- Starlark rules providing a persistent worker had to ship a .bazelrc file that sets --strategy=Mnemonic=worker (i.e. look at rules_scala). 

- Bazel has hardcoded defaults for native action mnemonics. For example, Bazel will use sandboxing (if it's available) for all actions by default but has a hardcoded default to use persistent workers for Java compilation actions.

- To configure fallback strategy one had to provide additional flag `--remote_local_fallback_strategy=`.

All of the above are now unnecessary with this change and the default behaviour is much more reliable and predictable.

### Example
I want to configure a build to run remotely and fallback onto `local` strategy in case remote execution is not possible. The configuration would be something like:

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
This is how my [first example](#example) will look like now:

``` 
$ bazel build
 --spawn_strategy=remote,local
 ... 
```

And if I want a custom strategy for my Java rules I can still add `--strategy=Javac=`:

```
$ bazel build
 --spawn_strategy=remote,local
 --strategy=Javac=worker
 ...
```

In this case, Java rules will be executed using a persistent *worker*, everything else will be executed *remotely* or *locally* (if remote is not possible).
Isn't it much shorter and simpler?

## How to use it

- Don't set any flags and Bazel will try to do the best automatically: Use remote execution if it's available, otherwise persistent workers, otherwise sandboxed execution, otherwise non-sandboxed execution.
- I want the best sandboxed build on my Linux machine and no automatic fallback to symlink-only sandboxing, non-sandboxed execution and no persistent workers: `--spawn_strategy=linux-sandbox`.
- I want persistent workers for actions that support it, but otherwise only sandboxed execution: `--spawn_strategy=worker,sandboxed`.
- I want to ensure everything runs remotely: `--spawn_strategy=remote`. Be careful, this configuration will cause a build failure in case bazel finds any action that cannot be executed remotely.

### How to migrate
You would know that you need to migrate if you see the following error:
 
```
ERROR: No usable spawn strategy found for spawn with mnemonic %Mnemonic%. Are your --spawn_strategy or --strategy flags too strict?
```

The general advice here would be to remove any `--spawn_strategy`, `--strategy`, `--remote_local_fallback_strategy=` or `--strategy_regexp=Regex=` flags that you might be setting manually or via a .bazelrc file, this will allow bazel to automatically detect suitable execution strategy.
In case this is not working for you, review the above [how-to-use section](#how-to-use-it) for ideas. 

### Contact us
Note that the change was made behind the [incompatible flag](https://github.com/bazelbuild/bazel/issues/7480), so please ping us in case of any difficulties.
