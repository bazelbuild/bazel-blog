---
layout: posts
title: "List based execution strategy"
authors:
  - ishikhman
---
**tl;dr**: changes are coming with bazel 0.27 release: bazel supports list based execution strategy; build will fail if action cannot be executed with provided list of strategies; bazel will *auto-detect* a suitable strategy if none provided.

## How it was before bazel 0.27 release
Bazel supports a bunch of flags to configure an execution strategy:

- The user can set the execution strategy in general and for individual action mnemonics using the flags `--spawn_strategy=`, 
`--strategy=Mnemonic=` and `--strategy_regexp=Regex=`. The flags take a single strategy name as a value.  
Example: `--spawn_strategy=linux-sandbox`

- Bazel has a hardcoded and undocumented list of mnemonics that are known to work well with certain strategies and uses these 
unless the user overrides them *individually* using `--strategy=Mnemonic=` flags.  
Example: Bazel will use some kind of sandboxing by default if its available on your system, otherwise non-sandboxed execution (e.g. on Windows). However, it will run Javac actions via the persistent worker strategy.

- Each strategy has custom code to deal with the situation that it can't execute a given action.  
Example: the remote strategy silently falls back to sandboxed execution if an action can't run remotely. 
The sandbox strategy silently falls back to non-sandboxed local execution if an action doesn't support sandboxing. 
There's no good way to configure this behavior.

### Example #1
I want to configure my build to run remotely and fallback onto `local` strategy in case remote execution is not possible. My configuration would be something like:

``` 
$ bazel build
 --spawn_strategy=remote
 --strategy=Javac=remote
 --strategy=Closure=remote
 --strategy=Genrule=remote
 --remote_local_fallback_strategy=local
 ... 
```


## How it is after bazel 0.27
- The user can pass comma-separated lists of strategies to the above mentioned flags: `--spawn_strategy=remote,worker,linux-sandbox`.  
Each strategy now knows whether it can execute a given action.
For any action that it wants to execute, Bazel just picks the first strategy from the given list that claims to be able to execute the action. 

- Bazel now *auto-detects* the execution strategy, if no strategy flag provided.  
If none of the strategy flags was used, bazel will generate a default list of strategies `remote,worker,sandboxed,local` and, for every action it wants to execute, will pick up the first strategy that can execute it.

- If action cannot be executed with any of the given strategies, build will fail.  
If any of the strategy flags is provided, then bazel will use ONLY those strategies that are listed there. 
Which means that `--spawn_strategy=remote` will NOT fallback to a `sandboxed` strategy or to any other strategy in case remote action failed or not possible at all.
Moreover, `--remote_local_fallback_strategy=local` is now deprecated and even if it was provided, bazel will ignore it and build would still fail. 

### Why is it better?
- Now you can control your execution strategy and have your build fail if any non-sandboxable or non-remotable action sneaks in! 
More reproducibility and safety for your builds!
- The strategies no longer do their own custom fallback, simplifying the code and unifying the behavior.
- You might even completely forget about strategies configurations if the default behavior satisfies your needs.

### Example #2
This is how my [first example](#example-1) will look like now:

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

If that is the case or you want to migrate proactively, see below some ideas on how to fix it.

- Do you use the strategy selection flags `--strategy` or `--spawn_strategy` or `--strategy_regexp`?  
You'll want to revisit the values you set them to. If you get an error like above, consider adding a fallback strategy to your settings. For example, `--spawn_strategy=sandboxed,local` instead of `--spawn_strategy=sandboxed`.

- Do you currently patch your Bazel version to remove fallback to non-sandboxed execution?  
This should no longer be necessary then! 
For example, something like `--spawn_strategy=linux-sandbox` will never fallback to `local` execution anymore.

- Do you execute your build or part of it remotely using `--strategy=remote` and/or `--spawn_strategy=remote`?  
Now you do not need to specify those strategies anymore - consider removing those `strategy` flags completely! In this case bazel will pickup the first available strategy from the default list, which is `remote`, unless you want to specifically forbid any non-remote executions or to configure custom fallback plan (see next advice).

- If you were using custom fallback strategy for the remote execution, e.g. `--remote_local_fallback_strategy=worker`, just add a fallback strategy to the list, for example: `--spawn_strategy=remote,worker`. 
Note, `--remote_local_fallback_strategy` flag defaults to `local`, so even if you have never used the flag it was implicitly there for every execution with a `--strategy=remote` flag. If you want to keep the same behavior, now you'd either need to use a default strategy or add a `local` to your custom strategy list: `--spawn_strategy=remote,local`.

- If you are using `--config=remote` in your build you might need to change your .bazelrc file, where all the `remote` configs are located, including `strategy` flags. The above pieces of advice apply to the .bazelrc configurations as well.
In a simple case, you might completely remove the following lines from .bazelrc (.bazelrc version of [the first example](#example-1):

```
  build:remote --spawn_strategy=remote
  build:remote --strategy=Javac=remote
  build:remote --strategy=Closure=remote
  build:remote --strategy=Genrule=remote
  build:remote --remote_local_fallback_strategy=local
```

or adapt them to your needs:

```
  build:remote --spawn_strategy=remote,local
```

### Contact us
Note that the change was made behind the [incompatible flag](https://github.com/bazelbuild/bazel/issues/7480), so please ping us in case of any difficulties.
