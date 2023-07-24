---
layout: posts
title: "What's New with Bzlmod?"
authors:
 - wyv
---

Since the official launch of Bzlmod in Bazel 6.0 in December 2022, the team has been hard at work improving Bzlmod in time for enabling it by default in 7.0, slated to be launched by the end of this year. This blog post will give you an idea of what we've done so far, and what changes you can expect in the future.


## Changes since 6.0

* **[Lockfile support](https://bazel.build/external/lockfile)** (partially available in 6.2.0, fully available in 6.3.0): Bazel now outputs a lockfile, `MODULE.bazel.lock`, next to the `MODULE.bazel` file, which contains information about the resolved module dependency graph and extension evaluation results.
* **[`mod` command](https://bazel.build/external/mod-command)** (available in 6.3.0): Bazel now supports a new command that allows the user to inspect the external dependency graph, and look at modules, repos, and extensions in detail.
* **[New docs](https://bazel.build/external/overview)**: The documentation for Bzlmod on bazel.build has been reorganized. Old content has been rewritten to be up to date and clearer, and new content such as the Bzlmod [migration guide](https://bazel.build/external/migration) has been added.
* Other new minor functionality and fixes. The most user-visible changes include:
    * Module extensions can now return a [metadata object](https://bazel.build/rules/lib/builtins/module_ctx#extension_metadata) specifying the list of repos to be specified in the `use_repo` clause of your MODULE.bazel file. This helps Bazel output a Buildozer command that automatically updates `use_repo` clauses. (Thanks to [Fabian Meumertzheim](https://github.com/fmeum) for this contribution!)
    * Module dependencies can now specify a [`max_compatibility_level`](https://bazel.build/rules/lib/globals/module#bazel_dep.max_compatibility_level), reducing the pain introduced by a compatibility level increase. (Thanks to [Brentley Jones](https://github.com/brentleyjones) for this contribution!)
    * The `native` object has gained several new methods to help Build macro authors work in a Bzlmod build: [`module_name`](https://bazel.build/rules/lib/toplevel/native#module_name), [`module_version`](https://bazel.build/rules/lib/toplevel/native#module_version), and [`package_relative_label`](https://bazel.build/rules/lib/toplevel/native#package_relative_label).
    * Overrides in non-root modules no longer cause an error, and are silently ignored instead. In other words, they are now implicitly "dev dependencies".
    * Bazel no longer appears to hang at the "Info: Invocation ID" message while fetching external dependencies.


## Upcoming for 7.0

Besides the changes above, we have several Bzlmod features planned for Bazel 7.0, including:

* **[A true repository cache](https://github.com/bazelbuild/bazel/issues/12227)**: Bazel's `--repository_cache` flag is actually an HTTP download cache, and does not include the extracted contents of fetched repos. We plan to introduce an actual cache for the extracted contents, which might also allow different workspaces on the same machine to share extracted repos.
* **[Offline and vendor mode](https://github.com/bazelbuild/bazel/issues/18934)**: Bazel will offer a way to prefetch all necessary external repos to set up offline work. These repos can optionally be fetched into the source tree, effectively _vendoring_ them.
* **[REPO.bazel](https://github.com/bazelbuild/bazel/issues/18077)**: This new file will replace WORKSPACE as the repo boundary marker (in addition to MODULE.bazel), and allows you to specify repo-wide common attributes.

We now have a [timeline view](https://github.com/orgs/bazelbuild/projects/16/views/1) of upcoming Bzlmod work as a GitHub project, where you can keep track of the team's progress and efforts.


## High-level roadmap for the future

As we presented in the Bzlmod Birds-of-a-Feather session at BazelCon 2022, we plan to gradually move to Bzlmod and phase out WORKSPACE over the next few years.

* **Bazel 7.0 (EOY 2023)**
    * Bzlmod is enabled by default (`--enable_bzlmod` defaults to true).
    * WORKSPACE can be disabled with a flag (new flag `--enable_workspace` defaults to true).
* **Bazel 8.0 (EOY 2024)**
    * Bzlmod can no longer be disabled (`--enable_bzlmod` is effectively always true and moved to the graveyard).
    * WORKSPACE is disabled by default (`--enable_workspace` defaults to false).
* **Bazel 9.0 (EOY 2025)**
    * WORKSPACE can no longer be enabled (`--enable_workspace` is effectively always false and moved to the graveyard).

Of course, the future is hard to predict, and we might need to adjust this timeline depending on how the ecosystem's migration to Bzlmod goes. Regardless, the team will spend considerable effort in supporting migration and ensuring the proliferation of common dependencies in the BCR.


## In closing: a call for migration

As Bzlmod matures and more dependencies become available in the BCR, migration to Bzlmod is becoming more approachable. We'd like to encourage you to use Bzlmod by default in new projects, and start migration for existing projects. Not only will you get to enjoy the benefits of Bzlmod over WORKSPACE, you'll also be helping the ecosystem by making the road less rocky for future users.

The team is eager to hear your feedback. We've been in touch with community members who answered the consumer satisfaction survey and provided feedback on Bzlmod. To address that feedback, we've updated the migration guide, and are connecting with various other teams and projects regarding their Bzlmod support (including IntelliJ, `rules_kotlin`, and gRPC).

If you'd like to participate, we're reachable through the various communication channels as always. Please feel free to email [bazel-discuss@googlegroups.com](mailto:bazel-discuss@googlegroups.com), [start a GitHub discussion](https://github.com/bazelbuild/bazel/discussions/new/choose), or find us on the #bzlmod channel on [Slack](https://slack.bazel.build/).

Until next time!
