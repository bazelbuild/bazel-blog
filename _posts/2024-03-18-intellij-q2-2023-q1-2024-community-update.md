---
layout: posts
title: Bazel Plugin for IntelliJ Community Update (Q2 '23 - Q1 '24)
authors:
  - mai93
  - keertk
---

## Master branch vs Google branch
The [Bazel IntelliJ plugin](https://github.com/bazelbuild/intellij) has had two main branches (`master` and `google`) for almost two years now. We created this structure to more easily accept contributions from the community, including those that are not too applicable or relevant for Google. 

The Bazel plugins for IntelliJ and CLion are built and released from the [master](https://github.com/bazelbuild/intellij) branch. An external team of maintainers addresses IntelliJ and CLion plugin issues and pull requests. The Android Studio plugin is built and released from the [google](https://github.com/bazelbuild/intellij/tree/google) branch. Internal Google teams review Android Studio plugin issues and pull requests on a case-by-case basis.

These two branches are now diverging from each other.

- Changes for IntelliJ and CLion plugins are **_only_** merged into the master branch. Few fixes that are also needed for the Android Studio plugin can be merged into the google branch after the internal teams’ approval.
- Changes made by the internal Google teams are automatically exported to the google branch. **Only relevant commits (security and selected bug fixes, and feature requests) are cherry-picked from the _google_ branch to the _master_ branch.**
- **The master branch is not intended to be used to build the Android Studio with Bazel plugin; failures of the Android Studio plugin built from the master branch will not be addressed.**

## Significant changes
The following is a list of significant changes made to the plugin from Q2 2023 to Q1 2024. Take a look at the complete list of [closed issues](https://github.com/bazelbuild/intellij/issues?q=is%3Aissue+is%3Aclosed+closed%3A2023-03-31..2024-03-31+) and [merged PRs](https://github.com/bazelbuild/intellij/pulls?q=is%3Apr+closed%3A2023-03-31..2024-03-31+-author%3Aapp%2Fcopybara-service+is%3Aclosed+). A big thank you to all PR authors and issue reporters!

**Performance improvements**

- Avoid scanning convenience symlink directories during initial import ([#6082](https://github.com/bazelbuild/intellij/issues/6082))
- Improve performance of Java package parser by making it a Bazel worker ([#3686](https://github.com/bazelbuild/intellij/pull/3686))
- Sync process optimizations by avoiding unnecessary computations ([#5219](https://github.com/bazelbuild/intellij/pull/5219))

**Bzlmod support**

- Recognize workspace root with `MODULE.bazel` as a valid workspace ([#6127](https://github.com/bazelbuild/intellij/pull/6127))

**Go development**

- Enable debugging the gazelle binary ([#5816](https://github.com/bazelbuild/intellij/pull/5816))
- Support embedded `go_source` rule type in `go_test` and `go_library` rules ([#5205](https://github.com/bazelbuild/intellij/pull/5205))

**CLion**

- Full Xcode toolchain support on macOS ([#4654](https://github.com/bazelbuild/intellij/pull/4654), [#4651](https://github.com/bazelbuild/intellij/pull/4651), [#4976](https://github.com/bazelbuild/intellij/pull/4976), [#5010](https://github.com/bazelbuild/intellij/pull/5010)) 
- Support for `strip_include_prefix` and `include_prefix` attributes; CLion will search for include headers using the correct paths ([#145](https://github.com/bazelbuild/intellij/issues/145), [#510](https://github.com/bazelbuild/intellij/issues/510), [#5300](https://github.com/bazelbuild/intellij/issues/5300))
- Code insight support for third party libraries stored within the project; breakpoints and other features are available for external targets stored inside the project and imported with `local_repository` or `new_local_repository` ([#4774](https://github.com/bazelbuild/intellij/issues/4774))
- Run main function-style tests in CLion ([#4786](https://github.com/bazelbuild/intellij/pull/4786)).
- Fixed the bug causing invalid CLI arguments to be passed to the executable during GDB debugging. ([#4783](https://github.com/bazelbuild/intellij/pull/4783))

**Plugin development**

- Plugin development now works on Windows ([#4843](https://github.com/bazelbuild/intellij/pull/4843))
- Fix plugin development on MacOS ([#4702](https://github.com/bazelbuild/intellij/pull/4702))

**Others**

- Buildifier calls now use the configuration from the default config file at the root of the workspace ([#6158](https://github.com/bazelbuild/intellij/pull/6158))
- Allow environment variables in run configurations ([#5885](https://github.com/bazelbuild/intellij/pull/5885))
- Introduce `try_import` section to allow importing optional .projectview files ([#5689](https://github.com/bazelbuild/intellij/pull/5689))
- Fix references for repo-relative labels in external workspaces ([#5164](https://github.com/bazelbuild/intellij/pull/5164))
- Allow targets with `manual` tag to be synced to the project ([#5085](https://github.com/bazelbuild/intellij/pull/5085))
- Allow setting custom Bazel run script file location ([#4690](https://github.com/bazelbuild/intellij/pull/4690))

## Releases
New versions of the plugin are continuing to be released every 2 weeks for [IntelliJ](https://plugins.jetbrains.com/plugin/8609-bazel), [CLion](https://plugins.jetbrains.com/plugin/9554-bazel), and [Android Studio](https://plugins.jetbrains.com/plugin/9185-bazel). The new versions are first released to the [Beta channel](https://github.com/bazelbuild/intellij#beta-versions) for users to experiment and report regressions that will be fixed before releasing to the Stable channel after 2 weeks.

Take a look at all [recent releases](https://github.com/bazelbuild/intellij/releases) along with release notes. We’re currently releasing for the following IDE versions: 

- IntelliJ & CLion: 2023.3 and 2024.1
- Android Studio: 2023.1 and 2023.2

## Resources

- **GitHub repository:** [https://github.com/bazelbuild/intellij](https://github.com/bazelbuild/intellij) 
- **IntelliJ plugin:** [https://plugins.jetbrains.com/plugin/8609-bazel](https://plugins.jetbrains.com/plugin/8609-bazel)
- **CLion plugin:** [https://plugins.jetbrains.com/plugin/9554-bazel](https://plugins.jetbrains.com/plugin/9554-bazel)
- **Android Studio plugin:** [https://plugins.jetbrains.com/plugin/9185-bazel](https://plugins.jetbrains.com/plugin/9185-bazel)  
- **Release notes:** [https://github.com/bazelbuild/intellij/releases](https://github.com/bazelbuild/intellij/releases)
- **Slack chat:** [https://slack.bazel.build](https://slack.bazel.build) (#intellij channel)
- **Google group:** intellij-bazel-plugin@googlegroups.com
- **Special Interest Group (SIG) meeting:** Held on the 3rd Thursday of every month. Take a look at our [charter](https://github.com/bazelbuild/community/blob/main/sigs/bazel-intellij/CHARTER.md) and reach out to messa@google.com to be added to the invite.

## Ideas, feedback, and submissions are welcome!
Thank you for reading this edition! Let us know if you'd like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Intellij Bazel Plugin Maintainers (intellij-bazel-plugin-maintainers@googlegroups.com)

_*Copyright © 2024 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
