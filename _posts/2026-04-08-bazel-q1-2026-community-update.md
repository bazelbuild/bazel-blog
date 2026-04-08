---
layout: posts
title: "Bazel Q1 2026 Community Update"
authors:
- karolinakalin
---

## Announcements

<img src="/assets/BazelCon 2026 banner.png"/>

### Mark Your Calendars: BazelCon 2026 is Heading to Amsterdam!

Get ready to build at scale in the heart of Europe. We are thrilled to announce that **BazelCon 2026** will be taking place in the vibrant city of **Amsterdam from October 13th–15th**.

Whether you’re a seasoned build engineer or just starting your journey with monorepos and hermeticity, this is the place to be. Expect three days of deep-dive technical sessions, hands-on workshops, and the chance to connect with the global community of maintainers and power users.

The Details at a Glance:

- *What:* BazelCon 2026

- *Where:* Postillion Hotel & Convention Centre Amsterdam, Netherlands

- *When:* October 13–15, 2026 

  - October 13th - Training Day

  - October 14th & 15th - 2 Conference days filled with technical sessions, Birds of a Feather and networking with the best in the field.

Registration opens April 22nd - register via the [BazelCon website](https://events.linuxfoundation.org/bazelcon/)!

For the most up to date BazelCon news and updates, follow the [Bazel X account](https://x.com/bazelbuild) and the [#bazelcon](https://bazelbuild.slack.com/archives/CDAGD8TGR) Bazel Slack channel. 

### Call for Proposals

Do you have a Bazel story to tell? We want to hear how you're using Bazel to solve complex problems, whether you’re optimizing massive monorepos or building custom rules for your team. Sharing your real-world wins and lessons learned helps the entire community grow, so don't hesitate to submit a proposal regardless of your experience level.

- CFP Opens: April 22

- CFP Closes: June 21

- Review Period: June 22 – July 8

- Speaker Notifications: July 20

- Schedule Announcement: July 22

The CfP submission form will be available via the [BazelCon website](https://events.linuxfoundation.org/bazelcon/).

### Want to become a Sponsor of BazelCon 2026?

Hosted by the Bazel Community in partnership with The Linux Foundation, BazelCon is the premier annual event for build enthusiasts, maintainers, and contributors to connect in an inclusive environment.

Sponsoring BazelCon 2026 puts your company right in front of the best build and platform engineers in the business. It is a great way to show your support for the community, meet key decision-makers, and find top talent to join your team. By becoming a partner, you help make the event possible while making sure the smartest people in tech know exactly who you are.

[Download the 2026 Sponsorship Prospectus Here.](https://events.linuxfoundation.org/bazelcon/sponsor/)

Email us at bazelcon-planning@bazel.build to reserve your sponsorship, ask questions, or talk about different options.


## Product Updates

### Upcoming Bazel releases

[Bazel 9.1.0](https://github.com/bazelbuild/bazel/issues/28365) is expected to release on on 2026-04-16. Please send cherry-pick PRs against the [release-9.1.0](https://github.com/bazelbuild/bazel/tree/release-9.1.0) branch before the RC1 cutoff on 2026-04-09.

[Bazel 8.7.0](https://github.com/bazelbuild/bazel/issues/28821) is expected to release on 2026-05-04. Please send cherry-pick PRs against the [release-8.7.0](https://github.com/bazelbuild/bazel/tree/release-8.7.0) branch before the RC1 cutoff on 2026-04-27.

### Q4 & Q1 releases

- [9.0.0](https://github.com/bazelbuild/bazel/releases/tag/9.0.0) has been released in January ‘26, followed by patch [9.0.1](https://github.com/bazelbuild/bazel/releases/tag/9.0.1).

- [8.6.0](https://github.com/bazelbuild/bazel/releases/tag/8.6.0) has been released in February ‘26.

- [8.5.0](https://github.com/bazelbuild/bazel/releases/tag/8.5.0) has been released in December ‘25, followed by patch [8.5.1](https://github.com/bazelbuild/bazel/releases/tag/8.5.1).

- [7.7.0](https://github.com/bazelbuild/bazel/releases/tag/7.7.0) has been released in October ‘25, followed by patch [7.7.1](https://github.com/bazelbuild/bazel/releases/tag/7.7.1).

- [6.6.0](https://github.com/bazelbuild/bazel/releases/tag/6.6.0) has been released in January ‘26. This release has also marked the end of support for Bazel 6.


## Community Corner

### Bazel for CLion plugin updates

A few updates from the JetBrains* team:

- Plugin supports Bazel 9 and comes now with Starlark REPL.

- C++ code insight under transitions is being rolled out. CLion Classic lets the user select resolve configuration for such files if more than one configuration is available, CLion Nova support for configuration switching is on the way.

- GoogleTest TEST_P macro is supported for individual test runs.

- Code insight takes into account conlyopts and cxxopts attributes.

- New PTY capable view is enabled by default for all outputs.

### BUILD Foundation

Announced at BazelCon 2025, the BUILD Foundation has been established as a Linux Foundation Directed Fund to accelerate the community roadmap for Bazel and related build technologies. While Google maintains governance of the core Bazel "kernel," the new fiscal entity provides a formal structure to fund improved documentation, rulesets, and open-source infrastructure.

The BUILD Foundation is now enrolling founding members.

Read the [Prospectus and Membership Entitlements](https://docs.google.com/presentation/d/14Yjm4gghabys0WrHgTNPlsaUmEWrgrSS_IEe2FJTzQ4/preview) to learn more about the values of becoming a member.

### Web Updates: Previews for the BCR and Bazel.build

**A New Look for the BCR:** The community is working together on a more modern way to explore the Registry. Head over to [bcr.stack.build](https://bcr.stack.build/) to see the new UI in action and see how the ecosystem is evolving.

**Evolving Bazel.build:** Thanks to a collaborative effort, the next version of our homepage is taking shape. Visit [preview.bazel.build](https://preview.bazel.build/) to see how we’re making documentation and resources easier for everyone to navigate.

### Upcoming Meetup.build events

[Build Meetup Munich](https://meetup.build/munich-2026) - May 11, 2026

### Community created content

**Articles**

[Goodbye Dockerfile, Hello Bazel: Doubling Our CI Speed ](https://plaid.com/blog/hello-bazel/) - by Nikita Chepanov and Oleg Dashevskii at Plaid

[Build less, merge faster: avoiding diamond merges with a merge queue ](https://plaid.com/blog/merge-queue/) - by Nikita Chepanov and Oleg Dashevskii at Plaid

[Bazel 9 Migration: How to Get Faster Builds Before the Bzlmod Refactor](https://pratikmahalle.medium.com/bazel-9-migration-how-to-get-faster-builds-before-the-bzlmod-refactor-d9591cd4f0fb) - by Pratik Mahalle

[Bazel for SONiC: What We've Learned and Contributed](https://blog.aspect.build/bazel-for-sonic) - by Şahin Yort

[Managing Bazel Flags in Monorepos with Flagsets (PROJECT.scl) ](https://adincebic.com/2026/03/08/managing-bazel-flags-in-monorepos.html) - by Adin Ćebić

[Composing Bazel rules with subrules](https://adincebic.com/2026/03/01/composing-bazel-rules-with-subrules.html) - by Adin Ćebić

[Lightning-fast BUILD file generation with Gazelle lazy indexing](https://blog.engflow.com/2025/11/25/lightning-fast-build-file-generation-with-gazelle-lazy-indexing/) - by Jay Conrod @EngFlow

[Bazel rule extensions](https://www.smileykeith.com/2025/10/31/bazel-rule-extensions/) - by Keith Smiley

[Build Snippets #1 - Affected Target Analysis with Bazel](https://deepinthebuild.github.io/changed-targets-tricks) - by Chris McDonald

[Migrating to Bazel symbolic macros ](https://www.tweag.io/blog/2025-11-20-migrating-bazel-symbolic-macros/) - by Alexey Tereshenkov @Tweag

**Videos**

[Bazel 9 is here! ](https://www.youtube.com/watch?v=QJUTeD43QlE) - by Aspect Build

[Tutorial: Set up Gazelle to automatically create your Bazel BUILD files ](https://www.youtube.com/watch?v=NaeXpna0avo) - & other beginner friendly videos by Jon Block [here](https://www.youtube.com/playlist?list=PLIb3cp7HaQiRqGI4P85X9Oko5uQNfNkVS).

[Bazel and Rust at OpenAI with David Zbarsky](https://www.youtube.com/watch?v=glJek6y-iQg) - by Aspect Build

[Zero-sysroot hermetic LLVM cross-compilation using Bazel](https://fosdem.org/2026/schedule/event/F8SDAA-zero-sysroot_hermetic_llvm_cross-compilation_using_bazel/) - FOSDEM talk by David Zbarsky and Corentin Kerisit

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
| [Bazel plugin for IntelliJ](https://github.com/bazelbuild/community/tree/main/sigs/bazel-intellij) | Monthly      |    en@jetbrains.com |
| [Remote execution API working group](https://docs.google.com/document/d/1EtQMTn-7sKFMTxIMlb0oDGpvGCMAuzphVcfx58GWuEM/edit?tab=t.0#heading=h.ol6wthckmbcw)      | Monthly      |   chiwang@google.com |
| [Supply chain security / SBOM](https://docs.google.com/document/d/1WhScaOLERet4Fxi4fa2Lpke2MgJZGvEE4EXeq6yb0LU/edit?usp=sharing)      | Weekly      |   fwe@google.com |


Interested in learning about SIGs or starting a new one? Find more information on our [website](https://bazel.build/community/sig).

Want to get your SIG listed? Please add it to the [Community repository](https://github.com/bazelbuild/community/tree/main/sigs).

## Ideas, feedback, and submissions are welcome!

Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Google Bazel team

**Copyright © 2026 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o.*
