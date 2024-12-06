---
layout: posts
title: "Bazel 8.0 LTS"
authors:
 - wyv
 - fweikert
 - keertk
---

We're pleased to announce the release of Bazel 8.0!

This LTS release marks a significant step forward for Bazel, offering a more streamlined and efficient build experience. With Bzlmod as the default for dependency management and major rulesets fully migrated to Starlark, Bazel 8.0 empowers you to build with greater speed and flexibility.
This release also includes a number of bug fixes, performance enhancements, and new features to improve your workflow.

Read on to explore the key highlights of Bazel 8.0, and be sure to check out the [full release notes](https://github.com/bazelbuild/bazel/releases/tag/8.0.0) for a complete overview of the changes.

## Bazel 8 key highlights

### Starlarkification: modularization of rules

A significant change in Bazel 8.0 is the ongoing effort to modularize rules using Starlark. Many rules previously bundled with Bazel are now split into their own modules. This includes rules for Android, C++, Java, Protobuf, and Shell.

- **Android:** All android_* build and repo rules have migrated to [rules_android](https://github.com/bazelbuild/rules_android). Android tools are no longer bundled within Bazel.
- **C++:** All C++ toolchain-related symbols have been moved to [rules_cc](http://github.com/bazelbuild/rules_cc). Other symbols, including the rules themselves, will be moved in a future release.
- **Java:** All java_* rules now reside in [rules_java](https://github.com/bazelbuild/rules_java).
- **Protobuf:** *_proto_library rules have been moved to [protobuf](https://github.com/protocolbuffers/protobuf).
- **Python:** All py_* rules and providers (like PyInfo) have been moved to [rules_python](http://github.com/bazelbuild/rules_python).
- **Shell:** All sh_* rules are now part of [rules_shell](https://github.com/bazelbuild/rules_shell).

To ease this transition, Bazel 8.0 introduces the `--incompatible_autoload_externally` flag which automatically loads rules from their respective repositories, thus removing the need for an imminent migration. The migration to use load statements needs to happen in 2025 before Bazel 9 is released. Load statements are supported on Bazel versions 6, 7 and 8, so the migration is largely independent of the Bazel version.

### Bzlmod: the new default for dependency management

Bzlmod was introduced in Bazel 5 in 2021 as an experimental feature, it became GA in Bazel 6 and turned on in Bazel 7. In Bazel 8, the new powerful external dependencies system works with the old WORKSPACE mechanism turned off by default. This shift means that Bazel no longer automatically reads the WORKSPACE and WORKSPACE.bzlmod files when building your project. These files were previously required for defining external repositories and dependencies, but Bzlmod offers a more modern and efficient approach.

Since Bzlmod was launched, the [Bazel Central Registry](https://registry.bazel.build/) growth has accelerated from Bazel release to Bazel release:

<img src="/assets/bazel8.png" style="width:50%; height:50%;"/>

The BCR now hosts more than 500 Bazel modules with 2500+ different versions.

We encourage all users to migrate to Bzlmod and take advantage of its benefits. Take a look at this [migration guide](https://bazel.build/external/migration) for step-by-step instructions and best practices for moving from the traditional WORKSPACE setup to the streamlined Bzlmod system.

We are aiming to remove all WORKSPACE functionalities in Bazel 9.

### Symbolic macros

Symbolic macros offer a new way to write macros that are safer to use and that catch bugs sooner. For example, their arguments are typed like rule attributes, and the author decides which attributes permit select()s based on whether the macro needs to examine that value or pass it through. With Symbolic macros come several related features:

- A new macro-aware visibility model, which protects a macro's internal targets from being depended on by its caller
- Rule Finalizers, which are macros that can call native.existing_rules() with less surprising behavior
- A way for a macro to inherit the attribute schema of another rule or macro that it wraps.

Check out the [documentation on macros](https://bazel.build/extending/macros) for more details.

## Bazel 5 deprecation

With the launch of Bazel 8.0, we're announcing the upcoming deprecation of Bazel 5.0. Starting January 2025, Bazel 5 will no longer receive critical bug fixes, security updates, or OS compatibility support.

We strongly encourage you to upgrade to Bazel 8.0 to benefit from the latest features, performance improvements, and ongoing support. You can also opt for a rolling release to stay up-to-date with the newest developments at HEAD.

Refer to our [release model](https://bazel.build/release) for more details.

## What’s next?

**Try out Bazel 8.0!** This is a significant release that brings a wealth of improvements. We encourage all Bazel users to explore the new features and migrate to Bazel 8.0 to take advantage of its enhancements. Questions? Want to discuss something specific? File an [issue](https://github.com/bazelbuild/bazel) or start a [discussion](https://github.com/bazelbuild/bazel/discussions) on GitHub so we can take a look.

**Stay connected!** To stay up-to-date on all things Bazel, read the Bazel [blog](https://blog.bazel.build/), join our [Slack](https://slack.bazel.build), follow [@bazelbuild](http://twitter.com/bazelbuild) on X (Twitter), join the bazel-discuss@googlegroups.com mailing list, or reach out to product@bazel.build. We would love to hear any feedback you may have!

In closing, we’d like to extend our sincere gratitude to the entire Bazel community. Every bug report, code contribution, ruleset improvement, and discussion played a role in shaping Bazel 8.0. Thank you for your continued support and dedication to making Bazel better with every release!
