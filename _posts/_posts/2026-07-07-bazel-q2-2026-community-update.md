---
layout: posts
title: "Bazel Q2 2026 Community Update"
authors:
- karolinakalin
---

## Announcements

<img src="/assets/BazelCon 2026 banner.png"/>

### BazelCon 2026 - details

The Details at a Glance:

- *What:* BazelCon 2026

- *Where:* Postillion Hotel & Convention Centre Amsterdam, Netherlands

- *When:* October 13–15, 2026 

  - October 13th - Training Day

  - October 14th & 15th - 2 Conference days filled with technical sessions, Birds of a Feather and networking with the best in the field.

Get your ticket and find all the details via the [BazelCon website](https://events.linuxfoundation.org/bazelcon/)!

For the most up to date BazelCon news and updates, follow the [Bazel X account](https://x.com/bazelbuild) and the [#bazelcon](https://bazelbuild.slack.com/archives/CDAGD8TGR) Bazel Slack channel. 

### Call for Proposals

This year, we received a tremendous 170 talk submissions!

A huge thank you to everyone who took the time to submit a proposal. The Review Committee is already diligently reviewing them to curate the 2026 schedule.

Speaker confirmations will be sent out on July 20th, and we will announce the schedule a few days later. If your submission isn't selected this year, we highly encourage you to apply again next time - and we sincerely applaud your willingness to share your stories with the community!

### BazelCon Training Day

Following last year’s success, we are bringing back Training Day right before the main conference.

[The schedule](https://events.linuxfoundation.org/bazelcon/features/training-day/) features two parallel tracks with four sessions each, allowing you to choose one session per time slot. You can select your sessions when you secure your BazelCon ticket on the website.

_Already registered?_ You can easily edit your existing registration to secure a spot in the trainings of your choice.

**Please Note:** Seats are limited. If your plans change and you can no longer attend, please free up your spot so someone on the waitlist can take your place.


## Product Updates

### Upcoming Bazel releases

[Bazel 9.2.0](https://github.com/bazelbuild/bazel/issues/29355) is expected to release on 2026-07-09. [RC1](https://github.com/bazelbuild/bazel/releases/tag/9.2.0rc1) was released on 2026-06-25.

[Bazel 8.8.0](https://github.com/bazelbuild/bazel/issues/29489) is expected to release on 2026-07-15. Please send cherry-pick PRs against the [release-8.8.0](https://github.com/bazelbuild/bazel/tree/release-8.8.0) branch before the RC1 cutoff on 2026-07-08.

### Q2 releases

- [9.1.0](https://github.com/bazelbuild/bazel/releases/tag/9.1.0) was released in April ‘26, followed by patch [9.1.1](https://github.com/bazelbuild/bazel/releases/tag/9.1.1).

- [8.7.0](https://github.com/bazelbuild/bazel/releases/tag/8.7.0) was released in May ‘26.


## Community Corner

### Updates from the JetBrains* team:

**Bazel for CLion plugin updates**

- Debug flags are no longer injected automatically by debug run configurations. If your build already includes debug symbols, this change shouldn't impact you; otherwise, check the details here: [https://jb.gg/clwb-debug-docs](https://jb.gg/clwb-debug-docs).

- You can now switch configurations if the current source file is built under multiple configurations in your project. Additionally, when you start debugging, we'll automatically select the correct configuration to keep your code insight and debug session in sync.

**Developments in the Bazel plugin by JetBrains for IntelliJ IDEA, PyCharm and GoLand in 2026.1**

- Improved stability and less freezes: all known freezes caused by the Bazel plugin have been fixed.

- Sync performance improved, with overhead removed. Less spurious analysis cache invalidations.

- Better hot swap in JVM applications.

- Graceful cancellation for Bazel run and build.

- Bazel 9 compatibility.

- More readable build and sync progress in IDE output.

- Find more details on the plugin "What's New" page.

In the upcoming 2026.2 version, the team is focusing on improved support for Bazel projects with Python and Go, in particular when opened in PyCharm and GoLand.

### Meetup.build events

Check out the recaps of the latest Build meetups organised by EngFlow!

[EngFlow x Uber Amsterdam Build Meetup 2026: Scaling Builds](https://blog.engflow.com/2026/04/14/engflow-x-uber-amsterdam-build-meetup-2026-scaling-builds/) - hosted in the Uber office, the attendees got to enjoy 6 talks on all things Build.

[Munich Bazel Build Meetup 2026: Tackling Supply Chain Security and Monorepo Scalability](https://blog.engflow.com/2026/06/17/munich-bazel-build-meetup-2026---tackling-supply-chain-security-and-monorepo-scalability/#how-i-tried-to-produce-otel-traces-out-of-bep) - the community met in the Salesforce offices for more great talks and knowledge sharing. Recordings of talks will soon be available to watch online.

Keep an eye on [meetup.build](http://meetup.build) for next meetup announcements.

### Community created content

**Articles**

- [Remote Cache CDC: Reusing Bytes](https://www.buildbuddy.io/blog/content-defined-chunking/) - by Tyler French @BuildBuddy 

- [Accessing external resources reliably with Bazel](https://www.tweag.io/blog/2026-04-02-making-bazel-builds-more-reliable/) - by Alexey Tereshenkov @Tweag

- [Building and running Bazel applications on AutoSD: Toolchains, containers, and recommended practices](https://developers.redhat.com/articles/2026/06/10/building-and-running-bazel-applications-autosd#) - by Bilal Elmoussaoui

- [Mastering Your Frontend Build with Bazel: Testing](https://dev.to/mbarzeev/mastering-your-frontend-build-with-bazel-testing-mlg) - by Matti Bar-Zeev

- [Mastering Your Frontend Build with Bazel: Consolidating Tests](https://dev.to/mbarzeev/mastering-your-frontend-build-with-bazel-consolidating-tests-26nl) - by Matti Bar-Zeev

- [A Practical Introduction to Bazel Persistent Workers](https://adincebic.com/2026/05/10/a-practical-introduction-to-bazel.html) - by Adin Ćebić

- [Cleaning up old Bazel patterns](https://adincebic.com/2026/06/07/cleaning-up-old-bazel-patterns.html) - by Adin Ćebić

- [Micro-Benchmarking Java with JMH and Bazel](https://medium.com/@somaktukai/micro-benchmarking-java-with-jmh-and-bazel-cdf74dc714f6) - by Somak Dutta

- [Why Bazel is the Endgame for Build Systems](https://thecodinggopher.substack.com/p/why-bazel-is-the-endgame-for-build) - by The Coding Gopher

**Videos**

- [Introduction to the Bazel build system](https://www.youtube.com/watch?v=GMx6YwdELl4) - by Florent Castelli, presented during Sweden Cpp

- [Bazel for SONiC: What We've Learned and Contributed](https://www.youtube.com/watch?v=uSKCNDWuXjc) - by Borja Lorente @Aspect Build

- [Bazel and Rust at OpenAI with David Zbarsky](https://www.youtube.com/watch?v=glJek6y-iQg) - by Aspect Build

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
