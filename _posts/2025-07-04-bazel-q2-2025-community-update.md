---
layout: posts
title: "Bazel Q2 2025 Community Update"
authors:
 - karolinakalin
---

## Announcements

### BazelCon 2025

We’re excited to invite you to BazelCon 2025 in Atlanta, Georgia! Join the amazing Bazel Community for two days of talks, Birds of a Feather sessions, and networking, all focused on the Bazel build system. Thanks to our generous sponsors, the event is completely free to attend. 

This year, we’re also offering a special Community Training Day on November 9th to help you deepen your expertise. Check the [schedule](https://events.linuxfoundation.org/bazelcon/features/training-day/#writing-bazel-rules) and see what Aspect Build, EngFlow and Tweag have in store for you!

Don’t miss this chance to learn, share, and connect—register through the BazelCon website*.

- **Venue:** Omni Hotel, Atlanta, Georgia
- **9th November:** Community Training Day
- **10-11th November:** BazelCon

**Accomodation:** 
This year, BazelCon is hosted alongside KubeCon + CloudNativeCon. Our attendees can book chosen hotels at these events [Venue+Travel tab](https://events.linuxfoundation.org/kubecon-cloudnativecon-north-america/attend/venue-travel/#hotel-information), benefiting from the room block and fixed prices. Please note, rooms will most likely sell out in advance of the room block close dates listed on the website. We advise you to book early to secure a room at the conference rate.

*As BazelCon is a free event with a limited capacity, we encourage everyone to be thoughtful about their registrations. If it becomes apparent you will not be able to join us, please cancel your attendance to give others an opportunity to attend. 

### Call For Proposals

If you have insights, projects, or practical experiences with Bazel that could benefit the community, we invite you to submit a proposal for BazelCon 2025. Talks and Birds of a Feather sessions are all welcome. Your contributions can help spark meaningful discussions and knowledge sharing among peers. If you’re interested in presenting, please fill out our [Call for Proposals form](https://events.linuxfoundation.org/bazelcon/program/cfp/). We look forward to your submissions - CFP closes August 10th!

### BazelCon talk recordings 2017-2024 now available on Linux Foundation Channel 

Per popular request, we have moved all past BazelCon recordings to the Linux Foundation YouTube channel. The previous channel that hosted these has been hidden, which resulted in the videos not showing up in search.
This has now been fixed and you can access all playlists [through the LF channel](https://www.youtube.com/@LinuxfoundationOrg/playlists), as well as searching for them by name in the search bar.

## Product updates

[Bazel 8.4.0](https://github.com/bazelbuild/bazel/tree/release-8.4.0) release branch is now open. Please send cherry-pick PRs against this branch if you'd like your change to be implemented, and follow the [release tracking issue](https://github.com/bazelbuild/bazel/issues/26362) for updates.

**Q2 releases**

- [Bazel 8.2.0](https://github.com/bazelbuild/bazel/releases/tag/8.2.0) was released in April ‘25, followed by patch [8.2.1](https://github.com/bazelbuild/bazel/releases/tag/8.2.1).

- [Bazel 8.3.0](https://github.com/bazelbuild/bazel/releases/tag/8.3.0) was released in June ‘25, followed by a patch [8.3.1](https://github.com/bazelbuild/bazel/releases/tag/8.3.1).

## Community Corner

### JetBrains’* new Bazel plugin coming soon

The Bazel plugin team at JetBrains is preparing their [new Bazel plugin](https://plugins.jetbrains.com/plugin/22977-bazel-eap-/) for IntelliJ IDEA, PyCharm and Goland for general availability later in July, together with the 2025.2 release of IntelliJ IDEA. Compared to the old plugin originally developed by Google, the new plugin features a closer integration with the IntelliJ IDEA project model, allowing more accurate highlighting, completions and refactoring in JVM languages, as well as many smaller usability improvements. The GA release will additionally support Python and Go targets. A full release announcement will be posted on the [IntelliJ IDEA blog](https://blog.jetbrains.com/idea/category/releases/) when it becomes available.

### JetBrains’ Bazel Plugin 2025.1 for IntelliJ IDEA

The recent updates to JetBrains' Bazel Plugin for IntelliJ IDEA, culminating in the 2025.1 release, bring a range of improvements, rolled out by JetBrains incrementally over recent months, aim to make working with Bazel projects inside IntelliJ IDEA more efficient.

Some enhancements include:

- **Full Bazel 8 & nested modules support:** Seamlessly work with the latest Bazel features and complex project structures.
- **Experimental phased sync:** Drastically reduces initial sync times, letting you start coding and browsing almost instantly, leaving heavier tasks happening in the background.
- **Python & Scala support:** Full IDE experience for these languages, including run and debug, as well as code assistance and syncing targets.
- **Smart dependency management:** Quickly add missing dependencies directly from code.
- **Enhanced Starlark support:** Better in-editor documentation and smarter code completions for BUILD files.
- **Improved test workflows:** Debug and run tests with coverage directly within the IDE.
- **Streamlined navigation & setup:** Easier access to targets, improved search, and quick-start project templates.
- **Project admin tools:** Features like "shard sync" and managed .bazelproject for large-scale consistency.

For a deeper dive on these and more features, visit [Justin Kaeser’s article](https://blog.jetbrains.com/idea/2025/04/what-s-new-in-bazel-plugin-2025-1/) here.

### A few words from JetBrains on Bazel for IntelliJ and CLion Plugin Updates

  ‘’Starting from the second week of July, the plugins will officially support the 2025.2 version of JetBrains IDEs. This also means that support for 2024.3 is no longer maintained, and the final released plugin version for 2024.3 is 2025.06.10.0.1.

We apologize for the various Bazel execution-related issues in the versions released in March and April. Huge thanks to everyone who provided feedback in the #intellij channel on Bazel Slack and on the plugin’s GitHub page. Versions 2025.05.13.0.1 and later include fixes that address the reported regressions.

**C++ Support Updates**

Over the past year, we have improved C++ support in the plugin, including cc_toolchain support for code analysis, and added MSVC support on Windows. Feel free to read the article on the JetBrains blog about the new features of the plugin: https://jb.gg/bazel-clion-2025.

We received some feedback about issues with CLion Nova and the Bazel plugin, resulting in the “Processing XXX file changes” dialog appearing and becoming stuck. The issue was indeed in the CLion Nova engine (CPP-44506) and was fixed in CLion 2025.1.2. However, manual cache invalidation is required on the user side via the “Invalidate Caches” action in CLion.

Starting from version 2025.06.24.0.1, the Bazel for CLion plugin includes additional fixes for performance issues with the same user-visible symptom (“Processing XXX file changes”). This version will be available on JetBrains Marketplace in the second week of July. Please note that the same cache invalidation action is required after the upgrade.’’

### Build Meetup in Munich - Recap

The [Build Meetup in Munich](https://blog.engflow.com/2025/04/25/munich-build-meetup-recap---engflow--jetbrains/), co-hosted by EngFlow and JetBrains, brought together build system professionals for a valuable evening of insights. Discussions covered everything from Bazel fundamentals and advanced configuration management to handling large datasets, optimizing C/C++ dependencies, and even building an entire Linux OS with Bazel. The meetup also explored the complexities of remote execution, emphasizing the balance between customization and automation. For a deeper dive into some of the slides and takeaways, go to the full article!

### Articles

- [Securing Bazel's Module Registry](https://blog.aspect.build/securing-bcr) - by Alex Eagle @Aspect Build
- [Bazel's Original Sins](https://fzakaria.com/2025/06/22/bazel-s-original-sins) - by Farid Zakaria
- [Bazel Knowledge: Homonymous Bazel Modules](https://fzakaria.com/2025/06/15/bazel-knowledge-homonymous-bazel-modules) - by Farid Zakaria
- And many more, on [fzakaria.com](http://fzakaria.com)
- [Dagger and Bazel](https://blog.aspect.build/dagger-and-bazel#heading-community) - by Chris Chinchilla @Aspect Build
- [Gojek’s Journey to 3x Faster iOS Builds with Bazel](https://medium.com/gojekengineering/gojeks-journey-to-3x-faster-ios-builds-with-bazel-90fbe3f22f81) - by Sanju Naik
- [Migrating to Bazel Modules (a.k.a. Bzlmod)](https://blog.engflow.com/2025/05/14/migrating-to-bazel-modules-aka-bzlmod---toolchainization/) - Toolchainization - by Mike Bland @EngFlow
- [Migrating to Bazel Modules (a.k.a. Bzlmod) - Repo Names, Again…](https://blog.engflow.com/2025/04/17/migrating-to-bazel-modules-aka-bzlmod---repo-names-againhellip/) - by Mike Bland @EngFlow

### Videos

- [Using Bazel for C++ development and more](https://www.youtube.com/watch?v=Y19ErHiOwQI) - talk by Evgenii Novozhilov
- [Easy Build with Bazel](https://www.youtube.com/playlist?list=PLbauki92IzGyoWQdOKo_1gSt4jrB5O9rS) - video playlist by Byte Anatomy
- [The Hidden Cost of Bazel with Alex Eagle from Aspect Build](https://www.youtube.com/watch?v=32i-QKuuhPE) - by Ankit Jain @Aviator
- [How we made CLion understand your Bazel Project](https://youtu.be/_gxQM25v5aE) - talk by Daniel Brauner
- [Production-Ready C++ with Bazel](https://www.youtube.com/watch?v=mvxrDN9mtTU) - by Alex Eagle @Aspect Build
- [Developer Tooling in Monorepos with bazel_env - feat. Fabian Meumertzheim](https://www.youtube.com/watch?v=TDyUvaXaZrc) - by Alex Eagle @Aspect Build
- [Getting Started with Angular 20 in a Bazel Monorepo](https://www.youtube.com/watch?v=c74kIWLIICA) - by Alex Eagle @Aspect Build

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
