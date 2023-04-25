---
layout: posts
title: Bazel Plugin for IntelliJ Q1 2023 Community Update
authors:
  - keertk
  - mai93
  - raoarun
---

Welcome to the Q1 2023 edition of the Bazel Plugin for IntelliJ Community Update!

## Master branch vs Google branch
Last year we created a new Bazel IntelliJ development branch that lives independent of Google Bazel IntelliJ plugin branch.  We created this new branch so that we can easily ingest contributions from the community - including those that are not relevant for Google. 

Details on the [Bazel IntelliJ plugin branch](https://github.com/bazelbuild/intellij) (master):

- The Bazel plugin for IntelliJ and CLion are built from the Bazel IntelliJ plugin branch. Changes intended for the CLion and IntelliJ plugins are therefore expected to be made on this branch.
- An external team of maintainers addresses IntelliJ and CLion related issues and pull requests.

Details on the [Google branch](https://github.com/bazelbuild/intellij/tree/google):

- The Android Studio plugin is built from the Google branch. Changes that are intended for Android Studio must therefore be made in this branch.
- Internal Google teams review pull requests on a case-by-case basis.

## Community survey
We’d like to hear from you! Please fill out [this short survey](https://forms.gle/2gLmNF3uCnDBX6Ci7) to help us improve our product and community engagement. The survey is specific to the Bazel plugin for IntelliJ and shouldn’t take more than a few minutes to complete.

## Project board
We have created a [GitHub Project](https://github.com/orgs/bazelbuild/projects/5/views/1?layout=board) to enable the community to better track the status of recently opened issues and PRs in the IntelliJ repository. Please use this board to check where in the pipeline an issue/PR currently is:

- Untriaged: Recently opened
- Triaged: Appropriate labels and/or assignees have been added; priority not set 
- In progress: Actively being worked on
- Q2 2023: Planned to be worked on sometime in Q2
- Q3 2023: Planned to be worked on sometime in Q3
- Q4 2023: Planned to be worked on sometime in Q4
- Backlog (awaiting response): Waiting on a response from the user; assigned priority P1 or P2
- Backlog: Assigned priority P3 or lower; not currently planned
- Done: Completed and closed

## Issues
The following is a list of significant issues fixed in Q1 2023. You can find the complete list of closed issues [here](https://github.com/bazelbuild/intellij/issues?q=is%3Aissue+is%3Aclosed+closed%3A2023-01-01..2023-03-31).

- Fix Full Android APK build command [#4527](https://github.com/bazelbuild/intellij/pull/4527)
- Compatibility fixes for Bazel 6.0.0 [#4067](https://github.com/bazelbuild/intellij/issues/4067) and [#4349](https://github.com/bazelbuild/intellij/issues/4349)
- Fixes for issues with CLion 2022.3 [#4282](https://github.com/bazelbuild/intellij/issues/4282) and [#4168](https://github.com/bazelbuild/intellij/issues/4168)
- Fix running subscoped tests for Go [#3691](https://github.com/bazelbuild/intellij/issues/3691)

## Pull requests
The following is a list of significant PRs we merged in Q1 2023. You can find the complete list of merged PRs [here](https://github.com/bazelbuild/intellij/pulls?q=is%3Apr+closed%3A2023-01-01..2023-03-31+-author%3Aapp%2Fcopybara-service+is%3Aclosed).

- Fix Buildifier integration [#4550](https://github.com/bazelbuild/intellij/pull/4550)
- Allow for more flexibility when reporting test failures [#2148](https://github.com/bazelbuild/intellij/pull/2148)
- Fix passing "-oso_prefix ." in CLion [#4404](https://github.com/bazelbuild/intellij/pull/4404)
- Properly expand IntelliJ macros in run configurations [#4368](https://github.com/bazelbuild/intellij/pull/4368)
- Bazel 'info' command doesn't require target specification [#4281](https://github.com/bazelbuild/intellij/pull/4281)
- Remove site-packages from import string [#3808](https://github.com/bazelbuild/intellij/pull/3808)

## Releases
New versions of the plugin are continuing to be released every 2 weeks for [IntelliJ](https://plugins.jetbrains.com/plugin/8609-bazel), [CLion](https://plugins.jetbrains.com/plugin/9554-bazel), and [Android Studio](https://plugins.jetbrains.com/plugin/9185-bazel). The new versions are first released to the [Beta channel](https://github.com/bazelbuild/intellij#beta-versions) for users to experiment and report regressions that will be fixed before releasing to the Stable channel after 2 weeks.

Recent releases along with release notes can be found [here](https://github.com/bazelbuild/intellij/releases). We’re currently releasing for the following IDE versions: 

- IntelliJ & CLion: 2022.3 and 2023.1
- Android Studio: 2021.3 and 2022.2

## Other updates
We published a Bazel Q1 Community Update [blog post](https://blog.bazel.build/2023/03/28/bazel-q1-2023-community-update.html) where you can find key announcements and updates. We’d like to highlight the following which are most pertinent to the Bazel plugin for IntelliJ community:

**Bazel Day 2023:** Video recordings from Bazel Day are available on-demand and can be found on this Google Open Source YouTube [playlist](https://www.youtube.com/watch?v=0QX6zkzoFyY&list=PLxNYxgaZ8RseUZDQjfUZVGTRq79HyYTF0). We’d like to specifically highlight [Mai Essa](https://github.com/mai93)’s talk on the [Bazel IntelliJ plugin](https://www.youtube.com/watch?v=GV_KwWK3Qy8) - watch the video to get a walkthrough of the plugin's features and capabilities.

**Bazel 2023 roadmap:** We're excited to share our [2023 roadmap](https://bazel.build/about/roadmap)! This year, we aim to support IntelliJ IDEA IDE releases in partnership with JetBrains.* Please check the roadmap for regular updates throughout the year.

**Office hours pilot:** We have launched dedicated office hours to provide the Bazel team and community experts a forum to engage with users and contributors. This will run as a monthly pilot program for 3 months, with the following date remaining:

- [May 25th, 11am EST](https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=Nmh0dWdtaDVpMTlnamFtczVpcWhqaG04OWggY184NGJmMzAyNmQ4NmMxNDU2ZjZiMWY5OGZlYzEzN2FhZTljOGFlMDAzMWQxMDkyNWE3ZDIxNjZhMjgzNzEwMTc1QGc&tmsrc=c_84bf3026d86c1456f6b1f98fec137aae9c8ae0031d10925a7d2166a283710175%40group.calendar.google.com)

You can submit your questions beforehand through [this form](https://docs.google.com/forms/d/e/1FAIpQLSdAmEJN3twWz8Ko25oeXnMDyf4UjDlIw0pJA0esFcQy7rGFug/viewform) and join the live office hours session [here](https://meet.google.com/bbm-dqrv-mws) to get your questions answered on the Bazel IntelliJ plugin or any other topic.

**Backlog clean up:** We’ve taken steps to sustainably manage and maintain the growing backlog by closing out issues/PRs older than 6 months that aren’t likely to be addressed. If you’re still interested in pursuing one of the flagged or closed issues/PRs, please let our triage team know by tagging @bazelbuild/triage in a comment.

## Resources

- **GitHub repository:** [https://github.com/bazelbuild/intellij](https://github.com/bazelbuild/intellij) 
- **IntelliJ plugin:** [https://plugins.jetbrains.com/plugin/8609-bazel](https://plugins.jetbrains.com/plugin/8609-bazel)
- **CLion plugin:** [https://plugins.jetbrains.com/plugin/9554-bazel](https://plugins.jetbrains.com/plugin/9554-bazel)
- **Android Studio plugin:** [https://plugins.jetbrains.com/plugin/9185-bazel](https://plugins.jetbrains.com/plugin/9185-bazel)  
- **Release notes:** [https://github.com/bazelbuild/intellij/releases](https://github.com/bazelbuild/intellij/releases)
- **Slack chat:** [https://slack.bazel.build](https://slack.bazel.build)
- **Google group:** intellij-bazel-plugin@googlegroups.com
- **Special Interest Group (SIG) meeting:** Held on the 3rd Thursday of every month. Take a look at our [charter](https://github.com/bazelbuild/community/blob/main/sigs/bazel-intellij/CHARTER.md) and reach out to raoarun@google.com to be added to the invite.

## Ideas, feedback, and submissions are welcome!
Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Intellij Bazel Plugin Maintainers (intellij-bazel-plugin-maintainers@googlegroups.com)

_*Copyright © 2022 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
