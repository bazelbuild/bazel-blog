---
layout: posts
title: Bazel 6.0 LTS
authors:
  - radvani
---

# Bazel 6.0 launched!

Today, we launch Bazel 6.0 LTS! Bazel 6.0 delivers many requested customer updates to simplify Bazel usage and eliminate common Android app development roadblocks.

![Image](/images/Bazel6.0ReleaseBlogPost.png)

### Bzlmod becomes Generally available
[Bzlmod](https://bazel.build/docs/bzlmod) automatically resolves transitive dependencies, allowing projects to scale while staying fast and resource-efficient. In development since 2021, Bzlmod enters general availability with Bazel 6.0.

-   Pipelines to automatically check common dependencies and rulesets into the Bazel Central Registry.
-   Updated [Bzlmod Migration Guide](https://docs.google.com/document/d/1JtXIVnXyFZ4bmbiBCr5gsTH4-opZAFf5DMMb-54kES0/edit?usp=gmail) includes scripts and documentation for migration.
-   Added Bzlmod support for `rules_jvm_external`, allowing users to download Maven dependencies for Java projects.
  
## Build Android apps with Bazel
By popular customer request, Bazel 6.0 uses [D8](https://developer.android.com/studio/command-line/d8) for dexing and desugaring by default. With D8, you leverage the latest Android tooling when building mobile apps. Through [community contributions,](https://github.com/bazelbuild/bazel/pulls?q=is%3Apr+is%3Aclosed+label%3Ateam-android+closed%3A2021-11-01..2022-12-02+) Bazel Android builds now also support a variety of quality-of-life and efficiency improvements, such as persistent workers for resource processing and (optional) manifest permission merging.

## Optional toolchains
Our Developer Satisfaction survey indicated that rule authors want support for improved [toolchain development](https://bazel.build/versions/6.0.0/extending/toolchains#optional-toolchains). Bazel 6.0 allows authors to write rules using an [optional, high performance toolchains](https://bazel.build/docs/toolchains#optional-toolchains) when available, with a fallback implementation for other platforms.

## New build performance profiles
[Optimize for build productivity](https://blog.bazel.build/2022/11/15/build-performance-metrics.html) with new system and CPU related metrics data.

-   system load average (`--experimental_collect_load_average_in_profiler`)
-   worker memory usage (`--experimental_collect_worker_data_in_profiler`)
-   system network usage (`--experimental_collect_system_network_usage`)
    

## Control `.bzl` dependencies with load visibility
Now, rule and macro authors can declare a [load visibility](https://bazel.build/versions/6.0.0/concepts/visibility#load-visibility) for their `.bzl` files by calling the new [visibility()](https://bazel.build/versions/6.0.0/rules/lib/globals#visibility) built-in function. This restricts what parts of the workspace may `load()` the `.bzl` file, so that macros and rules do not automatically become public APIs.

Read [the full release notes for Bazel 6.0](https://github.com/bazelbuild/bazel/releases/tag/6.0.0).
