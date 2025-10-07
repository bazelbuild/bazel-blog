---
layout: posts
title: "Bazel Q3 2025 Community Update"
authors:
- karolinakalin
---

## Announcements

### BazelCon 2025

We're just a few weeks away from BazelCon 2025, and we can't wait to see you in Atlanta! Before the big event, we want to share a few important updates and reminders.

**A Special Thanks to Our Sponsors**

[BazelCon 2025](https://events.linuxfoundation.org/bazelcon/) is free to attend, and that's all thanks to the incredible support from our sponsors. Their generosity makes it possible to bring the community together for two days of learning, networking, and collaboration.

Seven sponsors are supporting the event this year. We'd like to extend a huge thank you to **BuildBuddy, EngFlow, Google, Aspect Build, Buildkite, JetBrains, Tweag and VirtusLab** for their continued support.

**Monday After-Hours Socializing**

Join us for more networking and fun after the final sessions of Day 1! BuildBuddy is sponsoring an evening **Happy Hour**, while EngFlow and JetBrains bring the fun with a **Game Night**. Make sure to save the date for good drinks, great conversation, and some friendly competition. 

Exact times and locations are coming soon! Find all the final details by keeping up with the **#bazelcon** channel on Bazel Slack, our Bazel X account [@bazelbuild](https://x.com/bazelbuild), and [meetup.build](https://meetup.build) for specific Game Night information.

**Hackathon Alert**

Extend your BazelCon experience by joining Aspect Build for a special hackathon on **Wednesday, November 12th!** This post-conference event will be held at the Omni Hotel, the same venue as the conference. It's a great opportunity to roll up your sleeves, collaborate with fellow Bazel enthusiasts, and build something cool!

[Register here](https://luma.com/jpc6qwaz) for the hackathon - there will be pizza.

**A Note on Registration**

As BazelCon is a free event with limited capacity, we kindly ask the attendees that if your plans have changed and you're no longer able to attend in person, please consider **canceling your registration through [the event website](https://events.linuxfoundation.org/bazelcon/).** This will free up a spot for someone else who is eager to join us. Your cooperation is greatly appreciated and helps us accommodate as many people as possible!

**Thank You to Our Speakers**

A massive thank you to everyone who submitted a proposal for BazelCon 2025! We were truly impressed by the quality and quantity of submissions. Your willingness to share your knowledge and passion for Bazel is what makes this event so special.

Congratulations to all the speakers whose talks have been accepted! The [final schedule](https://events.linuxfoundation.org/bazelcon/program/schedule/?ajs_aid=609585d1-0775-40bb-87f0-4a210baab403) has already been announced and we can't wait for you to share your insights with the community. 

Get ready for some fantastic talks and Birds of a Feather sessions - we look forward to seeing you all in November!

### Attestation Support in BCR

The Bazel Central Registry (BCR) now has enhanced security metadata with **attestation support**. This significant update, a collaborative effort between Aspect Build, the BCR team, and the Google Open Source Security Team, improves the software supply chain by enabling module maintainers to publish signed provenance with their releases. For those using Bazel modules, this means you'll have more security information to help you make informed decisions about your dependencies. To learn more about this new feature and how it can benefit you, [check out the full article](https://blog.bazel.build/2025/08/01/enhancing-security-metadata-in-bcr.html) by Appu Goundan and Florian Weikert on the Bazel blog.

## Product Updates

### Upcoming Bazel releases

The first release candidate of [Bazel 9.0](https://github.com/bazelbuild/bazel/issues/26992) will be cut on 2025-10-27. If you want to make sure your feature lands in 9.0, please add it to the [release blocker milestone](https://github.com/bazelbuild/bazel/milestone/94).

[Bazel 8.5.0](https://github.com/bazelbuild/bazel/issues/26904) is expected to release on 2025-11-10. Please send cherry-pick PRs against the [release-8.5.0](https://github.com/bazelbuild/bazel/tree/release-8.5.0) branch before the RC1 cutoff on 2025-11-03.

[Bazel 7.7.0](https://github.com/bazelbuild/bazel/issues/26534) is expected to release on 2025-10-20. Please send cherry-pick PRs against the [release-7.7.0](https://github.com/bazelbuild/bazel/tree/release-7.7.0) branch before the RC1 cutoff on 2025-10-13.

### Q3 releases

- [8.4.0](https://github.com/bazelbuild/bazel/releases/tag/8.4.0) was released in September ‘25, followed by patches [8.4.1](https://github.com/bazelbuild/bazel/releases/tag/8.4.1) and [8.4.2](https://github.com/bazelbuild/bazel/releases/tag/8.4.2).

## Community Corner

### Get Involved: Community Updates & Participation Opportunities

We're bringing you a few updates from the Bazel community, courtesy of Alex Eagle, highlighting new initiatives that are making Bazel easier to use and contribute to.

**A new foundation in the works**

A new foundation is being created at the Linux Foundation to fund work on OSS Bazel rules. If your company relies on community-driven projects—like bazel-contrib—consider asking your manager to contact your company's OSPO about joining as a founding member. Investment here translates directly into better, more reliable Bazel rules for everyone.

**A new home for Bazel Documentation**

Rules Authors SIG is funding a new hosting solution for Bazel's documentation site. The prototype is at a placeholder domain: [bazel.online](https://bazel.online). The SIG is currently determining it has parity and meets Google's requirements. If launched, this will give the community the ability to preview changes to the docs, and should enable better ongoing maintenance. 
You can participate and keep an eye on the development in the **#documentation** channel on Bazel Slack.

**More features in the Bazel Central Registry (BCR)**

[registry.bazel.build](https://registry.bazel.build) just got two key feature additions that improve discoverability and transparency:

- Starlark API Docs: The registry can now show Starlark API documentation for modules that publish docs with their releases. For an example, check out [https://registry.bazel.build/modules/jq.bzl](https://registry.bazel.build/modules/jq.bzl). You can learn how to publish your own docs by reading the guide on the Aspect blog.

- Deprecation Flags: Modules that are deprecated or come from an archived GitHub repository will now be clearly indicated with a warning sign. 

### JetBrains’* new Bazel plugin

JetBrains announced the general availability of their their [new Bazel plugin](https://plugins.jetbrains.com/plugin/22977-bazel-eap-/) for IntelliJ IDEA, PyCharm and Goland in July on the IntelliJ IDEA blog: [https://blog.jetbrains.com/idea/2025/07/bazel-ga-release/](https://blog.jetbrains.com/idea/2025/07/bazel-ga-release/).

Key features now include Go and Python support, and options to enable faster indexing. JVM language support has been reworked from the ground up to offer more accurate highlighting, completions and refactoring. Additionally, Windows compatibility has been improved and full editing features are now available for Starlark, .bazelproject, .bazelrc, and .bazelversion files.

JetBrains is continuously updating the Bazel plugin [documentation pages](https://www.jetbrains.com/help/idea/bazel.html), which now feature a ["Get started with Bazel"](https://www.jetbrains.com/help/idea/tutorial-get-started-with-bazel.html) tutorial.

### Meetup.build

If you enjoy meeting fellow build enthusiasts in person, we encourage you to keep an eye on [meetup.build](http://meetup.build) - the right place to find build community meetups and opportunities to learn and share knowledge. 

Upcoming meetups -
- [Munich Build Meetup](https://4mksw.share.hsforms.com/21ZG5vZFgQRSvnAzXRe_olQ) - October 13th
- London Build Meetup - February 2026
- New York Build Meetup - March 2026

### Articles
- [Understanding Bazel remote caching](https://blogsystem5.substack.com/p/bazel-remote-caching) - by Julio Merino
- [Bazel and action (non-) determinism](https://blogsystem5.substack.com/p/bazel-action-determinism) - by Julio Merino
- [Separating builds for different configs with Bazel](https://medium.com/@pikotutorial/separating-builds-for-different-configs-with-bazel-a03b40855e2a) - by pikoTutorial
- [Solving Monorepo Hell with Bazel: A Deep Dive into Modern Build Systems](https://medium.com/@erfan.mohebi/solving-monorepo-hell-with-bazel-a-deep-dive-into-modern-build-systems-f70c831bb227) - by Erfan Mohebi
- [Migrating Airbnb’s JVM Monorepo to Bazel](https://medium.com/airbnb-engineering/migrating-airbnbs-jvm-monorepo-to-bazel-33f90eda51ec) - by Thomas Bao
- [The 'outside of Bazel' pattern](https://blog.aspect.build/outside-of-bazel-pattern) - by Alex Eagle @Aspect Build
- [Bazel Knowledge: transition with style](https://fzakaria.com/2025/07/08/bazel-knowledge-transition-with-style) - by Farid Zakaria
- [Bazel Knowledge: Testing for clean JVM shutdown](https://fzakaria.com/2025/09/02/bazel-knowledge-testing-for-clean-jvm-shutdown) - by Farid Zakaria and more at [fzakaria.com](http://fzakaria.com) 
- [Embedded bare-metal C with Bazel and AVR](https://popovicu.com/posts/embedded-c-bazel-avr/) - by Uros Popovic
- [Simple Lua integration in Go](https://popovicu.com/posts/simple-lua-integration-in-go/) - by Uros Popovic and more at [popovicu.com](http://popovicu.com) 
- [Tutorial: Get started with Bazel](https://www.jetbrains.com/help/idea/tutorial-get-started-with-bazel.html) - by JetBrains
- [Understanding Apple Debug Info](https://www.smileykeith.com/2025/09/21/understanding-apple-debug-info/) - by Keith Smiley
- [How to Build Python Code with Bazel (and Why)](https://ohadravid.github.io/posts/2025-09-hello-bazel/?utm_source=www.pythonweekly.com&utm_medium=newsletter&utm_campaign=python-weekly-issue-713-september-11-2025) - by Ohad Ravid

### Videos

- [What is Bazel? A Beginner’s Guide for 2025](https://youtu.be/JLvnnJCBUxE?si=nI1kDdI7OZQK9mf8) - by Vitaly Bragilevsky
- [Bazel - Marcus Boerger - ACCU 2025](https://www.youtube.com/watch?v=B5Ei5sQwmBs) - talk given by Marcus Boerger at the ACCU Conference 
- [Bazel for Everyone? Hard Questions with Confluent Engineers](https://www.youtube.com/watch?v=oh_b19EtDHs) - by Alex Eagle @Aspect Build 
- [Better Bazel Flag Defaults with Markus Hofbauer](https://www.youtube.com/watch?v=-iLgTR1J47g) - by Alex Eagle @Aspect Build
- [Bazel Training 101](https://www.youtube.com/playlist?list=PLLU28e_DRwdswrrZaNqnFFm9OawpxN4CB) - playlist by Alex Eagle @Aspect Build
- [IDE Support for Bazel: JetBrains’ New Plugin with Justin Kaeser](https://www.youtube.com/watch?v=PzPH3MgoBMw) - by Alex Eagle @Aspect Build
- [How Tinder built and open-sourced Bazel-diff to transform their CI/CD at scale](https://www.youtube.com/watch?v=WlQahiQ8kLM) - by BuildKite
- [State of Swift and iOS in Bazel with Luis Padron and Brentley Jones](https://www.youtube.com/watch?v=WlQahiQ8kLM) - by Alex Eagle @Aspect Build
- [How Snowflake Transformed its C++ and Java Build Systems with Julio Merino](https://www.youtube.com/watch?v=gn3Of-0JNIA) - by Alex Eagle @Aspect Build

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
