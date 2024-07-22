---
layout: posts
title: "Bazel Q2 2024 Community Update"
authors:
 - karolinakalin
 - keertk
---

## Announcements

### BazelCon 2024

The Bazel community, in partnership with The Linux Foundation, is excited to announce [BazelCon 2024](https://blog.bazel.build/2023/05/25/save-the-date-bazelcon2023.html), taking place on October 14-15 at the Computer History Museum in Mountain View, CA.

Thanks to our sponsors, Google, BuildBuddy, EngFlow, AspectBuild, Gradle, and VirtusLab, we invite you to join us for two days of insightful presentations, networking opportunities, and engaging discussions on all things Bazel. [Registration](https://events.linuxfoundation.org/bazelcon/) is now open.

We can’t wait to see you there!

<img src="/assets/bazel-q2-2024-bazelcon.png"/>

### Developer satisfaction survey results

Thank you to everyone that participated in our Q1 2024 developer satisfaction survey! We've read through all submissions and we hear your feedback. While the majority of respondents expressed satisfaction with Bazel, we acknowledge the concerns raised and recognize the areas for improvement.

Key takeaways from the survey include:

- Strong satisfaction with remote caching, Starlark, and community engagement.
- Challenges with IDE integrations and the transition to Bzlmod.
- High demand for improved documentation on writing rules and multi-platform builds.
- The need for more beginner-friendly resources and clearer documentation on version-specific features.

Your feedback is invaluable as we prioritize future improvements. We appreciate your patience and continued support as we strive to make Bazel even better. Stay tuned for more updates!

## Product updates

### Releases

Bazel [7.2.0](https://github.com/bazelbuild/bazel/releases/tag/7.2.0) was released in Q2 ‘24, along with patch releases [7.2.1](https://github.com/bazelbuild/bazel/releases/tag/7.2.1) and [7.1.2](https://github.com/bazelbuild/bazel/releases/tag/7.1.2).

Bazel 7.3.0 is in progress and scheduled to be released in August. Follow the [release tracker issue](https://github.com/bazelbuild/bazel/issues/22677) for updates.

### Improvement of versioned docs

Thanks to Fabian Meumertzheim’s contribution ([#22725](https://github.com/bazelbuild/bazel/pull/22725)), you can now easily switch between different versions of the same page in the versioned docs. Take a look at the example below.

<img src="/assets/bazel-q2-2024-versioneddocs.png"/>

### Enforcement of cherry-pick criteria

To help keep Bazel stable, minimize regressions, and reduce the need for frequent patch releases, we'd like to enforce some of our rules for code changes after the first release candidate is released. This means:

- Only high-priority / critical fixes will be accepted
- New features will be postponed to the next release

Take a look at the [release page](https://bazel.build/release) for more details.

## Community corner

The community went on a creative spree this quarter! A huge thank you to all the authors that contribute their time and knowledge to create amazing educational content for all Bazel users. 🔥

- [Why is my Bazel build so slow?](https://www.buildbuddy.io/blog/debugging-slow-bazel-builds/) _by Maggie Lou (BuildBuddy)_
- [Running local tools installed by Bazel](https://blog.aspect.build/run-tools-installed-by-bazel) _by Alex Eagle (AspectBuild)_
- [Understanding Bazel](https://www.gisli.games/understanding-bazel) _by Gísli Konráðsson_
- [Reproducible Builds with Bazel](https://testdriven.io/blog/bazel-builds/) _by Gaspare Vitta_
- [Bazel Bites: A Tasty Metaphor for Streamlined Builds](https://blog.engflow.com/2024/03/28/bazel-bites-a-tasty-metaphor-for-streamlined-builds/) _by Sarah Adams and Shelby Neubeck (EngFlow)_
- [The Many Caches of Bazel](https://blog.engflow.com/2024/05/13/the-many-caches-of-bazel/) _by Benjamin Peterson (EngFlow)_
- [Sysroot package generation for use with toolchains_llvm](https://steven.casagrande.io/articles/sysroot-generation-toolchains-llvm) _by Steven Casagrande_
- [Open-source a language server for .bazelrc config files (demo)](https://github.com/bazelbuild/vscode-bazel/issues/1#issuecomment-2177094540) _by Adrian Vogelsgesang_

**Bazel Pod - Aspect Insights**

The Aspect Build team, with Alex Eagle as a host, created a Bazel podcast! 

- [Bazel's Tracing and Logging Facilities](https://www.youtube.com/watch?v=-O8VGbjiCF4&list=PLLU28e_DRwdtpojOqWM5UeFyxad7m9gCF&index=1) _with Tiago Quelhas_
- [What's new in Bazel 7.2](https://www.youtube.com/watch?v=otOxcuFWBtk&list=PLLU28e_DRwdtpojOqWM5UeFyxad7m9gCF&index=2) _with Brentley Jones_

You can listen to other episodes in the YouTube [playlist](https://www.youtube.com/playlist?list=PLLU28e_DRwdtpojOqWM5UeFyxad7m9gCF).

**Amsterdam Bazel Community Day**

On March 25th, EngFlow ([recap](https://blog.engflow.com/2024/04/30/amsterdam-bazel-community-day---engflow--bookingcom/)) and Booking.com ([recap](https://medium.com/booking-com-development/bazelday-amsterdam-2024-at-booking-com-a9d49b88c301)) held the 7th Bazel Community in the Booking.com headquarters. Check out the recordings of the sessions:

- [Opening remarks](https://www.youtube.com/watch?v=KJMdI9IaZ3E&list=PLxx_fSA_YtcUJ2_CyNFbKwUEAyvA1CLVC&index=1&t=5s&pp=iAQB) _by Helen Altshuler_
- [Adopting Bazel At Booking: A Bumpy Road](https://www.youtube.com/watch?v=a6ySQK1OBUo&list=PLxx_fSA_YtcUJ2_CyNFbKwUEAyvA1CLVC&index=2&pp=iAQB) _by Manuel Naranjo (Booking.com)_
- [Reproducible Cloud-Based Dev Environments For Bazel](https://www.youtube.com/watch?v=jQ_-Xmg-wVA&list=PLxx_fSA_YtcUJ2_CyNFbKwUEAyvA1CLVC&index=3&pp=iAQB) _by Antonio Di Stefano and Jan Keromnes (EngFlow)_
- [Bazel And Intellij 2024: State of IDE Integration](https://www.youtube.com/watch?v=pBKeHlQClfY&list=PLxx_fSA_YtcUJ2_CyNFbKwUEAyvA1CLVC&index=4&pp=iAQB) _by Justin Kaeser (Jetbrains)_
- [Lessons Learned: Adopting Bazel At Salesforce](https://www.youtube.com/watch?v=wwK3RIDZYZE&list=PLxx_fSA_YtcUJ2_CyNFbKwUEAyvA1CLVC&index=5&pp=iAQB) _by Gunnar Wagenknecht (Salesforce)_

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
| Android app development      | Monthly      |   ahumesky@google.com |
| [Bazel plugin for IntelliJ](https://github.com/bazelbuild/community/tree/main/sigs/bazel-intellij) | Monthly      |    messa@google.com |
| Remote execution API working group      | Monthly      |   chiwang@google.com |

Interested in learning about SIGs or starting a new one? Find more information on our [website](https://bazel.build/community/sig).

Want to get your SIG listed? Please add it to the [Community repository](https://github.com/bazelbuild/community/tree/main/sigs).

## Ideas, feedback, and submissions are welcome!

Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Google Bazel team
