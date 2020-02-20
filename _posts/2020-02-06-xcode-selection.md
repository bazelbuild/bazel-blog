---
layout: posts
title: Changes to Xcode selection in Bazel
authors:
  - susinmotion
---

One of our major projects in the last year has been improving build times for interactive iOS builds by adding support for the Google-internal remote execution service from Mac. Combined with [dynamic execution]({% post_url 2019-02-01-dynamic-spawn-scheduler %}), which helps mitigate deficiencies in our remote Mac executors by running some actions locally, we are now able to deliver the best possible clean and incremental build times.

This was a hands down performance improvement, but users kept opting out. Why? Were they nostalgic for slower builds?

## Background
Bazel performs Xcode selection based on the `--xcode_config` and `--xcode_version` flags. `--xcode_config` takes an instance of the `xcode_config` rule, which contains information about the default and available Xcode versions, and selects a single Xcode version to be used. The selected Xcode is either the value of the `--xcode_version` flag, if it’s available, otherwise it’s the default version of the `xcode_config`. The `xcode_config` rule also validates the values of both flags.

The original `xcode_config` rule takes a list of `xcode_version` targets for its `versions` attribute, and a single `xcode_version` as the `default`, like this:

```python
xcode_version(
    name = ‘xcode10.2’
    version = ‘10.2.1’
)

xcode_version(
    name = ‘xcode11.1’,
    version = ‘11.1’
)

xcode_config(
    name = ‘my_config’,
    default = ‘xcode10.2’,
    versions = [‘:xcode10.2’ ,’:xcode11.1’]
)
```

This shape works well for purely local or purely remote builds---that is, any case when all of the possible Xcodes are on a single platform.

However, having a single pool of Xcode versions doesn’t really express the reality for dynamic execution, where the remote and local platforms have separate, and potentially disjoint, sets of Xcode versions available. 

To make this rule shape work with dynamic execution, we used an `--xcode_config` that just contained the remotely available Xcode versions, then required our users to have the selected Xcode version (either `--xcode_version` or the remote default) installed on their machines.

## What’s wrong with that?
There are two problems here. 

First of all, the default version has no awareness of the locally available Xcode versions, which means that Bazel could choose an Xcode version that wasn’t available locally, and then fail to build. This was frustrating to developers, exacerbated by the fact that the resulting error message made it seem like *they’d* passed an invalid `--xcode_version`. We needed Bazel to select a more intelligent default.

More importantly, requiring that the selected Xcode version be available both locally and remotely was problematic for developers who needed to use the newest Xcode version before that Xcode version was available remotely. A common problem was that an engineers’ devices would auto-update to require the newest Xcode version, while we were still vetting and deploying that version to the remote build system, a process that could take weeks. Developers would disable dynamic remote builds, tolerate very slow local builds, and, not knowing when their Xcode version became remotely and they could re-enable dynamic execution, would suffer poor performance forever. We needed to figure out how to enable users to use the Xcode version of their choice, without requiring them to disable dynamic remote builds.

The solution we chose took two parts:
*  Adapting the Xcode config rule to better express the Xcode versions available for dynamic scheduling.
*  Configuring dynamic execution to tolerate local- or remote-only Xcode versions, by setting action execution requirements based on the availability of the selected Xcode.

## The new xcode_config rule
We first introduced a new rule, `available_xcodes`, which takes the same fields as the original `xcode_config` rule shape, but exposes them all instead of performing Xcode selection. 
 
```python
xcode_version(
    name = ‘xcode10.2’,
    version = ‘10.2.1’
)

xcode_version(
    name = ‘xcode11.1’,
    version = ‘11.1’
)

available_xcodes(
    name = ‘local_xcodes’,
    default = ‘xcode10.2’,
    versions = [‘:xcode10.2’ ,’:xcode11.1’]
)

available_xcodes(
    name = ‘remote_xcodes’,
    default = ‘xcode11.1’,
    versions = [,’:xcode11.1’]
)
```

Does that look familiar?


We then modified the `xcode_config` rule to accept two `available_xcodes` dependencies to represent the locally and remotely available Xcode versions. Note that this new shape doesn’t accept the original attributes, `default` and `versions`. These concepts are reflected in the `available_xcodes` dependencies.

```python
xcode_config(
    name = ‘my_config’,
    local_versions = ‘:local_xcodes’,
    remote_versions = ‘remote_xcodes’
)
```

## Xcode version selection
Both `xcode_config` shapes select the value of `--xcode_version` if it’s present, or else the default. They differ, however, in what constitutes the default, and in the behavior if the selected Xcode is only present on a single platform.

You might remember that we were using the remote `xcode_config` with dynamic execution, which resulted in build failures if the default (remote) version wasn’t available locally. We addressed this issue firstly by having the new `xcode_config` set a mutually available Xcode version as the default if possible (otherwise the default of the `local_versions` target), and secondly by allowing selection of any Xcode version present in `local_versions` or `remote_versions`.

A mutually available Xcode should result in the best performance, since it enables both local and remote execution, and since some actions (e.g. Swift compiles) must be executed locally, the local default is the next best thing. Xcode version selection occurs in this order, mutual first, then local default, but you can skip straight to the local default by passing `--experimental_prefer_mutual_xcode=false`.

Since the new `xcode_config` requires both dependencies to be set, we will never default to a remote-only Xcode version. We considered allowing a remote-only Xcode version in the absence of a locally available Xcode, but decided that preventing builds from failing cryptically if there was no Xcode to execute local actions was more important than providing the flexibility for dynamic execution to behave like a purely remote strategy.

## Configuring dynamic execution
The last piece is having Bazel execute actions in the right location based on the availability of the selected Xcode. If we’ve selected a local-only or remote-only Xcode, either via `--xcode_version` or by accepting the default, we want to keep the dynamic scheduler from trying to execute Xcode-related actions on the other system. 

We considered bypassing the dynamic scheduler by setting an overall execution strategy based on the Xcode availability. However, we *do* want to be able to use either platform for actions that don’t care about Xcodes (plus, this proposal was pretty complicated to implement). 

Instead, we had the dynamic scheduler set the execution strategy on a per-action basis. We did this by having the `XcodeConfig` provide a list of execution requirements, including location-based restrictions like `no-remote`. Implementations of rules that depend on `XcodeConfig` were modified to propagate these execution requirements to the actions they produce. The dynamic scheduler then checks each action for its location-based requirements, and disables the incompatible execution location, if there is one. 

## Takeaways
If you use dynamic execution, you should use the new `xcode_config` rule shape to get more flexibility, better defaults, and more reasonable error messages!

You should still use the old `xcode_config` shape for local-only or remote-only builds.

We’re excited to roll this out internally, so more developers can reap the benefits of dynamic scheduling.
