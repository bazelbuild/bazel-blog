---
layout: posts
title: "Bazel Q1 2025 Community Update"
authors:
 - karolinakalin
---

## Announcements

### 10th Anniversary of Bazel’s Public Launch

We have gone a long way since [we first said ‘’Hello World’’](https://blog.bazel.build/2015/03/27/Hello-World.html). Reflecting on this milestone, we just want to say thank you to all of you—our users, contributors, and the amazing community—who’ve been a part of this journey. Whether you’ve been with us since the beginning or joined along the way, your support, feedback, and collaboration have shaped Bazel into what it is today. Thank you for 10 years together!

### Q4 2024 - Bazel 8 and BazelCon

In December, we launched Bazel 8, making a big step towards a better and more efficient build experience for our users. The community has played a great role in shaping 8.0, with every bug report, code contribution and improvement discussions.

You can learn more at - 

- [Bazel 8.0 LTS](https://blog.bazel.build/2024/12/09/bazel-8-release.html) - blog post with all highlights of this release
- [Release notes](https://github.com/bazelbuild/bazel/releases/tag/8.0.0) - for a deeper dive

In November, we had the pleasure of co-hosting the community at BazelCon in California. With two days jam packed with exceptional talks, Birds of a Feather sessions and after-hours discussions, it was an unforgettable experience. 

- [BazelCon 2024: A celebration of community and the launch of Bazel 8](https://opensource.googleblog.com/2024/12/bazelcon-2024-bazel-8-launch.html)
- [BazelCon 2024 Recap: Recordings and Birds of a Feather Session Notes](https://blog.bazel.build/2024/11/19/bazelcon-recap.html)
- [BazelCon 2024 talks - full playlist](https://www.youtube.com/playlist?list=PLbzoR-pLrL6ptKfAQNZ5RS4HMdmeilBcw)

The event was so amazing, and we are already planning to do it all over again in 2025!

### Bazel User Survey

Thank you to everyone who took the time to fill out our 2025 user survey. We've read through all your feedback, and while most of you seem to be pretty happy with Bazel, we definitely hear your concerns and we're committed to making things even better.

You can find the survey result at [Bazel User Survey Results 2025](https://github.com/bazelbuild/bazel/discussions/25659).

Your feedback is incredibly valuable, and it helps us prioritize improvements for Bazel. We're grateful for your support and patience as we move forward. Stay tuned for upcoming updates!

### BCR Module growth

Since the release of Bazel 8, the Bazel Central Registry (BCR) has seen a significant increase in modules, growing from approximately 500 to over 650. This growth reflects the active contributions from the Bazel community, for which we are deeply grateful.

<img src="/assets/bazel-q1-2025-bcr-modules.png"/>

To help Bazel grow further, [check out the list of top wanted modules](https://github.com/bazelbuild/bazel-central-registry/issues?q=is%3Aissue%20state%3Aopen%20label%3A%22module%20wanted%22%20sort%3Areactions-%2B1-desc)! By contributing a module, you’re not only sharing your knowledge but also helping others save time, solve problems, and innovate faster.

## Product Updates

### Bazel 9 roadmap

We've shared our [roadmap for 2025](https://bazel.build/about/roadmap), with planned features for the Bazel 9 release at the end of the year. Notable items include deprecation of WORKSPACE functionality, Starlarkification of C++ rules and removal of autoloads, lazy evaluation of symbolic macros, and a new project-based model to reduce the cognitive burden introduced by Bazel flags. Let us know what you think!

### Releases

Bazel [8.2](https://github.com/bazelbuild/bazel/issues/25220) is in progress, with the 3rd release candidate released in early April. Please follow the release tracker for updates and get your cherry-picks in by the cut-off dates.

Recap of Q1 releases:

- Bazel [7.6](https://github.com/bazelbuild/bazel/releases/tag/7.6.0) was released in March ‘25.
- Bazel [8.1](https://github.com/bazelbuild/bazel/releases/tag/8.1.0) was released in February ‘25, along with patch [8.1.1](https://github.com/bazelbuild/bazel/releases/tag/8.1.1). 
- Bazel [7.5](https://github.com/bazelbuild/bazel/releases/tag/7.5.0) was released in January ‘25.

## Community Corner

**Build Meetups**

- 22nd May - [London Build Meetup](https://meetup.build/) Jane Street

**Articles**

- [Bazel Knowledge: Be mindful of Build Without the Bytes (bwob)](https://fzakaria.com/2025/01/12/bazel-knowledge-be-mindful-of-build-without-the-bytes.html) - Farid Zakaria
- [Bazel: Build Event Protocol Viewer](https://fzakaria.com/2025/01/28/bazel-build-event-protocol-viewer) - Farid Zakaria
- [Fast and Reliable Builds at Snowflake with Bazel](https://www.snowflake.com/en/engineering-blog/fast-reliable-builds-snowflake-bazel/) - Julio Merino
- [Unusual Builds with Bytes](https://www.buildbuddy.io/blog/unusual-builds-w-bytes/) - Son Luong Ngoc @BuildBuddy
- [Troubleshooting Bazel with Git Bisect](https://www.buildbuddy.io/blog/bisect-bazel) - Son Luong Ngoc @BuildBuddy
- [Migrating to Bazel Modules (a.k.a. Bzlmod) - Module Extensions](https://blog.engflow.com/2025/01/16/migrating-to-bazel-modules-aka-bzlmod---module-extensions/) - Mike Bland @EngFlow
- [Migrating to Bazel Modules (a.k.a. Bzlmod) - Fixing and Patching Breakages](https://blog.engflow.com/2025/03/25/migrating-to-bazel-modules-aka-bzlmod---fixing-and-patching-breakages/) - Mike Bland @EngFlow
- [Beautiful CI for Bazel](https://narang99.github.io/2025-03-22-monorepo-bazel-jenkins/) - Hariom Narang
Videos
- [Advanced Build Tools and Remote Execution API](https://fosdem.org/2025/schedule/event/fosdem-2025-4249-advanced-build-tools-and-remote-execution-api/) - Son Luong Ngoc @BuildBuddy
- [Writing Your Own BUILD Generator in Starlark](https://www.youtube.com/watch?v=FQJo73XatnM) - Alex Eagle @Aspect

## Resources

- GitHub repository: [https://github.com/bazelbuild/bazel](https://github.com/bazelbuild/bazel)
- Releases: [https://github.com/bazelbuild/bazel/releases](https://github.com/bazelbuild/bazel/releases)
- Slack chat: [https://slack.bazel.build](https://slack.bazel.build)
- Google group: bazel-discuss@googlegroups.com
- Special Interest Groups (SIG):

Reach out the email(s) listed below if you’d like to be added to the SIG calendar invites.

| **SIG**        | **Meeting frequency**           | **Point of contact**  |
| ------------- |-------------| -----|
| [Rules authors](https://github.com/bazelbuild/community/tree/main/sigs/rules-authors)     | Every two weeks | bazel-contrib@googlegroups.com |
| [Android app development](https://docs.google.com/document/d/1Sv227BguEekx5Q3lwSdPEQqpkHAng6J6gNCNZqJLbtw/edit?resourcekey=0-GK_iaQRAEAu3aYslzlrEfQ&tab=t.0#heading=h.dzj8kjjzgp3s)      | Monthly      |   ahumesky@google.com |
| [Bazel plugin for IntelliJ](https://github.com/bazelbuild/community/tree/main/sigs/bazel-intellij) | Monthly      |    messa@google.com |
| [Remote execution API working group](https://docs.google.com/document/d/1EtQMTn-7sKFMTxIMlb0oDGpvGCMAuzphVcfx58GWuEM/edit?tab=t.0#heading=h.ol6wthckmbcw)      | Monthly      |   chiwang@google.com |
| [Supply chain security / SBOM](https://docs.google.com/document/d/1WhScaOLERet4Fxi4fa2Lpke2MgJZGvEE4EXeq6yb0LU/edit?usp=sharing)      | Weekly      |   fwe@google.com |


Interested in learning about SIGs or starting a new one? Find more information on our [website](https://bazel.build/community/sig).

Want to get your SIG listed? Please add it to the [Community repository](https://github.com/bazelbuild/community/tree/main/sigs).

## Ideas, feedback, and submissions are welcome!

Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Google Bazel team

_*Copyright © 2025 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
