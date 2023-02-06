---
layout: posts
title: Bazel Plugin for IntelliJ H2 2022 Community Update
authors:
  - keertk
---

_A modified version of this blog was originally sent out to the IntelliJ Plugin distribution list on December 15, 2022._

## Welcome!
Welcome to the inaugural edition of the Bazel Plugin for IntelliJ community update! We hope to build a stronger and more inclusive community, and encourage more participation by keeping you informed on what’s happening in this space.
 
We welcome feedback! Please provide your thoughts on this edition by filling out [this feedback form](https://forms.gle/HiXcoixbr7TqySHs9).

## Product highlights
In November 2022, several members of the Bazel community gathered together in New York for [BazelCon](https://opensourcelive.withgoogle.com/events/bazelcon2022), an annual event hosted by the Google Bazel Team. The following videos are available on-demand and provide a lot of valuable insights:

- [Keynote](https://www.youtube.com/watch?v=SiKov9W7QT4&t=1s): Jeff Cox talks about short term and long term goals for Bazel for 2023, current and future OSS investments, and insights into the value both to Google and 3rd party developers globally.
- [State of the Union](https://www.youtube.com/watch?v=6_RrNxuny6Y): Radhika Advani, Sven Tiffe, and John Field share 2022 achievements, customer success stories, and 2023 plans. Learn about the Bazel roadmap, community contributions, and how you can participate in advancing the state of Bazel.

One of the key topics discussed was the Bazel plugin for IntelliJ and efforts made in this area in 2022, as shown below.

![Image](/assets/blog-intellij-h2-2022-maintenance-model.png)

This year, JetBrains and others [joined as co-maintainers](https://blog.bazel.build/2022/07/11/Bazel-IntelliJ-Update.html) of the [Bazel IntelliJ plugin repository](https://github.com/bazelbuild/intellij) and are actively reviewing contributions, tracking overall repository health, and adding new capabilities to the Bazel IntelliJ Plugin. This new co-maintenance model  has ensured a seamless intake process and reduced the turnaround time for pull requests raised in this repository.

At BazelCon, we also organized a Birds of a Feather session for the Bazel IntelliJ plugin where a few of our co-maintainers ([Mai Hussien](https://github.com/mai93), [Justin Kaeser](https://github.com/jastice), and [Marcin Abramowicz](https://github.com/abrams27)) presented key updates and had fruitful discussions with the audience on existing features, challenges and pain points, as well as on the future of the Bazel IntelliJ plugin integration. 

We’re committed to making sure our community succeeds by driving contribution excellence – e.g. resolving pull requests and reviewing issues in a timely manner, as well as improving documentation, examples, and tutorials. We also have a monthly SIG meeting that you’re all invited to and encouraged to join! Feel free to bring any topics for discussion and hear from members of the community. 

We encourage you all to contribute to the IntelliJ plugin. This truly is a joint effort between the Google Bazel team, co-maintainers, partners, and community champions. Be on the look out for “good first issue” or “help wanted” labels on issues. We’re aiming to add these more consistently to make it easier for you to identify areas for contribution.  

Let us know if we can help in any way during the process - we’re just a [Slack](https://slack.bazel.build) message away. 

![Image](/assets/blog-intellij-h2-2022-partner.png)

## Issues
More focus has been directed to the issues reported by external Bazel plugin users. The issue fixes improved the plugin main functionalities, e.g. debugging and testing for more languages like Kotlin, Go, C++ and Scala on different IDEs. The following is a list of significant issues fixed in H2 2022. You can find the complete list of closed issues [here](https://github.com/bazelbuild/intellij/issues?q=is%3Aissue+is%3Aclosed+closed%3A2022-07-01..2022-12-31).

- Maintain package structure in Go external libraries ([#1744](https://github.com/bazelbuild/intellij/issues/1744) and [#2365](https://github.com/bazelbuild/intellij/issues/2365)).
- Android Studio Mobile-install run configuration failed ([#3793](https://github.com/bazelbuild/intellij/pull/3793), [#2328](https://github.com/bazelbuild/intellij/issues/2328), and [#2084](https://github.com/bazelbuild/intellij/issues/2084)).
- CLion debugging is broken MacOS ([#2101](https://github.com/bazelbuild/intellij/issues/2101)).
- Partial sync gives sponge2 link instead of error messages ([#3877](https://github.com/bazelbuild/intellij/issues/3877)).
- Java fast test compilation failure does not output a link with new Sync window ([#3919](https://github.com/bazelbuild/intellij/issues/3919))
- Native Build Rules Point to 404'ing URL ([#3730](https://github.com/bazelbuild/intellij/issues/3730)).
- Support Kotlin coroutines debugging ([#2317](https://github.com/bazelbuild/intellij/issues/2317)).
- It is now possible to use Gateway with Bazel ([#3152](https://github.com/bazelbuild/intellij/issues/3152)).

## Pull requests
With the new maintenance model of the plugin and the collaboration between maintainers from different companies, we are reviewing and merging more pull requests than before. The merged PRs made improvements to different areas of the plugin such as supporting the latest IDE versions and fixing main functionalities for multiple languages. The following is a list of significant PRs we merged in H2 2022 and the complete list of merged PRs can be found [here](https://github.com/bazelbuild/intellij/pulls?q=is%3Apr+closed%3A2022-07-01..2022-12-31+-author%3Aapp%2Fcopybara-service+is%3Aclosed).

- Add running Gazelle as a step in the sync process ([#3910](https://github.com/bazelbuild/intellij/pull/3910)).
- Automatically import projects from directories (to open Bazel projects with remote IntelliJ) ([#3601](https://github.com/bazelbuild/intellij/pull/3601)).
- Allow running single Scalatest tests in IntelliJ ([#3744](https://github.com/bazelbuild/intellij/pull/3744)).
- Support Starlark nested function definitions ([#4035](https://github.com/bazelbuild/intellij/pull/4035)).
- Fix main repo target parsing ([#4009](https://github.com/bazelbuild/intellij/pull/4009)).
- Enable the Autoscroll to console by default ([#4006](https://github.com/bazelbuild/intellij/pull/4006)).
- RemovedAction should delegate isDumbAware ([#3789](https://github.com/bazelbuild/intellij/pull/3789)).
- Include implicit dependencies from proto compilers ([#3248](https://github.com/bazelbuild/intellij/pull/3248)).
- fix(test-go): add test_env to output all test results ([#3028](https://github.com/bazelbuild/intellij/pull/3028/files)).
- Support IntelliJ and CLion 2022.3 ([#4019](https://github.com/bazelbuild/intellij/pull/4019)).
- Fix reported regressions on 2022.3 ([#4126](https://github.com/bazelbuild/intellij/pull/4126), [#4074](https://github.com/bazelbuild/intellij/pull/4074), [#4070](https://github.com/bazelbuild/intellij/pull/4070)).

## Releases
New versions of the plugin are being released every 2 weeks for [IntelliJ](https://plugins.jetbrains.com/plugin/8609-bazel), [CLion](https://plugins.jetbrains.com/plugin/9554-bazel), and [Android Studio](https://plugins.jetbrains.com/plugin/9185-bazel). The new versions are first released to the [Beta channel](https://github.com/bazelbuild/intellij#beta-versions) for users to experiment and report regressions that will be fixed before releasing to the Stable channel after 2 weeks.

[Recent releases](https://github.com/bazelbuild/intellij/releases) have focused more on fixing issues reported by external users.
 
We will continue to release plugin versions compatible with the new IDE releases (including EAPs) as early as possible. This  prevents blocking the users who want to upgrade their IDEs but cannot find Bazel support for the new versions.

## Developer support
Over 2022, we heard your feedback and made significant process improvements to drive developer support excellence and elevate the overall contributor experience. A few notable areas we worked on in the support sphere in H2 2022 include:

**Template refreshes:** To minimize contributor friction, we created [issue templates](https://github.com/bazelbuild/intellij/issues/new/choose) for bugs and feature requests to capture the required information from developers before an issue is raised. This process minimizes redundant contributor and maintainer communication.

**Better labels on GitHub:** We added 3 labels to the GitHub repository to allow us to more accurately  track issue and PR status:

- awaiting-user-response: awaiting a response from author in a PR (e.g. after maintainer asks a question or asks to make edits to the PR)
- awaiting-review: awaiting review from maintainers in a PR (e.g. when PR is opened or after an author makes edits to the PR)
- awaiting-maintainer: awaiting a response from maintainers in an issue (e.g. when an issue is opened or after an author asks a question) 

**Issue resolutions and triaging:** Our support engineers are triaging issues and PRs promptly, and assigning the appropriate labels to many co-maintainers with the goal of improving developer experience and efficiency.

**Automation:** We’re working on a bot to automate the process of applying and removing labels on GitHub when certain actions are performed. This will save time and improve accuracy. Additionally, we plan to send out a short survey to contributors once an issue is resolved, to gather feedback on their experience.

**Manual plugin testing:** Manual testing of the plugin after a release to the beta channel is being done every other week, for Java, Kotlin, and GoLang.

**Releases and announcements:** Biweekly beta and stable releases for IntelliJ/CLion and Android Studio are part of our release cadence. We will send out emails to the community Google group(intellij-bazel-plugin@googlegroups.com) after every beta/stable release.

**Backlog:** Burning down open backlog issues in a timely manner is a top priority for us in 2023. Our prioritization process will involve reviewing and identifying issues that can be closed - if no longer relevant or beneficial to the community - so please look out for our comments on GitHub.

## Community corner
This is a space for the Bazel IntelliJ plugin community voice. If there is anything interesting you’re building or any updates you would like to include in future community updates, please reach out to raoarun@google.com.

Here’s what some of our co-maintainers have worked on in H2 this year:

**Borja Lorente Escobar ([@blorente](https://github.com/blorente)):**

The initial implementation of the Gazelle integration with the plugin has landed on the main branch ([PR](https://github.com/bazelbuild/intellij/pull/3910))! With this, users will be able to configure a Gazelle target to run before every sync, automatically keeping their files up to date.

The integration reads the **directories**: field of your Project View, and passes it to Gazelle, so it will only run on the sources you have imported into the editor. To enable it, specify a target in the **gazelle_target**: field of your Project View.

**Tomasz Pasternak ([@tpasternak](https://github.com/tpasternak)):**

Fixed CLion debugging on MacOS with [pr/4003](https://github.com/bazelbuild/intellij/pull/4003). Also worked on IntelliJ 2022.3 support ([pr/4019](https://github.com/bazelbuild/intellij/pull/4019)) and fixed the regressions reported by users with PRs: [#4126](https://github.com/bazelbuild/intellij/pull/4126), [#4074](https://github.com/bazelbuild/intellij/pull/4074), [#4070](https://github.com/bazelbuild/intellij/pull/4070).

## Resources

- **GitHub Repository:** https://github.com/bazelbuild/intellij 
- **IntelliJ Plugin:** https://plugins.jetbrains.com/plugin/8609-bazel
- **CLion Plugin:** https://plugins.jetbrains.com/plugin/9554-bazel
- **Android Studio Plugin:** https://plugins.jetbrains.com/plugin/9185-bazel  
- **Release Notes:** https://github.com/bazelbuild/intellij/releases 
- **Slack Channel:** https://slack.bazel.build 
- **Google Group:** intellij-bazel-plugin@googlegroups.com
- **SIG Meeting:** Held on the 3rd Thursday of every month. Reach out to raoarun@google.com to be added to the invite.

## Ideas, feedback, and submissions are welcome!
Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates, or if you’d like to showcase your work in future “community corner” sections by [submitting this form](https://forms.gle/HiXcoixbr7TqySHs9). We look forward to hearing from you!

Thanks,

Intellij Bazel Plugin Maintainers (intellij-bazel-plugin-maintainers@googlegroups.com)
