---
layout: posts
title: "Bazel 7.0 LTS"
authors:
 - wyv
 - keertk
---

Bazel 7.0 has been released! 

Many multi-year efforts have landed in this release. Bzlmod, Build without the Bytes (BwoB), and Skymeld are all enabled by default. Platform-based toolchain resolution is also now enabled for Android and C++. Read on to learn more!

In addition, as the first release in a new LTS track, Bazel 7.0 comes with many backwards-incompatible changes. We've also taken this chance to remove many old, stale flags, to address the explosion of configuration knobs. Read the [full release notes for Bazel 7.0](https://github.com/bazelbuild/bazel/releases/tag/7.0.0).

## Bazel 7 key highlights

### Bzlmod

As we announced in a [previous blog post](https://blog.bazel.build/2023/07/24/whats-new-with-bzlmod.html), Bzlmod, Bazel's new modular external dependency management system, is now enabled by default (i.e. `--enable_bzlmod` defaults to true). If your project doesn't have a `MODULE.bazel` file, Bazel will create an empty one for you. The old `WORKSPACE` mechanism will continue to work alongside the new Bzlmod-managed system, so you are not required to migrate yet. We plan to disable the old `WORKSPACE` system by default in Bazel 8, and remove it altogether in Bazel 9.

Note that even if you have an empty `MODULE.bazel` file, Bazel 7 might behave differently from older versions because Bzlmod is enabled, particularly surrounding label stringification and runfiles handling. See the [Bzlmod migration guide](https://bazel.build/external/migration) for more information.

You may wish to plan a migration to remove content from the `WORKSPACE` file. At this time, such a migration is possible, but may run into challenges. For example, we are aware that some rulesets do not work with bzlmod yet. If you encounter a missing one, we ask you to file a “Module Wanted” issue on the [Central Registry](https://github.com/bazelbuild/bazel-central-registry/issues/new).

### Build without the Bytes (BwoB)

Build without the Bytes for builds using remote caching and/or remote execution is now [enabled by default](https://blog.bazel.build/2023/10/06/bwob-in-bazel-7.html) (i.e. `--remote_download_outputs` defaults to toplevel). This means that Bazel will no longer try to download any intermediate outputs from the remote server, but only the outputs of requested top-level targets instead. This significantly improves build performance. Bazel now also handles the case of an artifact falling out of the remote cache gracefully, by rewinding the build. 

### Merged analysis and execution (Skymeld)

Project Skymeld aims to improve multi-target build performance by removing the boundary between the analysis and execution phases, and allowing targets to be independently executed as soon as their analysis finishes.

### Platform-based toolchain resolution for Android and C++

Platform-based toolchain resolution is now enabled by default for Bazel's bundled Android and C++ rules. This change helps streamline the toolchain resolution API across all rulesets, obviating the need for language-specific flags (such as `--android_cpu` and `--crosstool_top`). It also removes technical debt by having Android and C++ rules use the same toolchain resolution logic as other rulesets. Full details for Android developers are available in the [Android Platforms announcement](https://blog.bazel.build/2023/11/15/android-platforms.html).

### Experimental rule extension APIs for rule authors

Using the flag `--experimental_rule_extension_api`, rule authors can test-drive [a set of new APIs](https://docs.google.com/document/d/1p6z-shWf9sdqo_ep7dcjZCGvqN5r2jsPkJCqHHgfRp4/edit#heading=h.5mcn15i0e1ch) intended to extend existing rules and to enhance structure and encapsulation. When defining a Starlark rule, one may set an `initializer` or a `parent` that points to a macro or to another rule, respectively. A new top-level `subrule` call becomes available which encapsulates a part of the rule's functionality. The API is still under active development and will become available when it stabilizes. Please give us feedback on whether the API is powerful enough for your use cases.

## Bazel 4 deprecation

As we launch Bazel 7, we also deprecate Bazel 4, which means we'll no longer backport critical fixes for security issues and OS-compatibility issues. All support for Bazel 4 will end in January 2024. Users are encouraged to upgrade to the latest LTS release or use rolling releases to keep up with the latest changes at HEAD.

Please refer to our [release model](https://bazel.build/release) for more details.

## What’s next?

Thank you to the Bazel community for all your contributions to Bazel 7! Whether you contributed to the Bazel codebase or to a ruleset, filed an issue, or participated in a GitHub discussion, you played an important role in this launch. We look forward to continuing to work together to add new features and make improvements to the product.

To stay up-to-date on all things Bazel, read the Bazel [blog](https://blog.bazel.build/), join our [Slack](https://slack.bazel.build) chat, follow bazelbuild on [X (Twitter)](http://twitter.com/bazelbuild), and join the bazel-discuss@googlegroups.com mailing list. For reports, file an [issue](https://github.com/bazelbuild/bazel) or start a [discussion](https://github.com/bazelbuild/bazel/discussions) on GitHub. As always, if you have any feedback, please reach out to product@bazel.build.
