---
layout: posts
title: "Bazel Q3 2024 Community Update"
authors:
 - karolinakalin
 - keertk
---

## Announcements

### BazelCon 2024

BazelCon is right around the corner!

First of all, thank you to all who registered - we are very happy to see the community excited for the conference. The attendance list is now full, with a waitlist open - if you have registered but cannot attend in person, please remember to unregister! Instructions are available [here](https://events.linuxfoundation.org/bazelcon/register/).

The [BazelCon 2024 schedule](https://events.linuxfoundation.org/bazelcon/program/schedule/) is jam packed with lightning and tech talks, Birds of a Feather sessions, and more exciting presentations for all levels of knowledge - from beginners to Bazel professionals. 
Although this year we are not providing live streaming of the event, we plan to upload recordings of the talks to the Linux Foundation YouTube channel. We’ll share the link to the playlist on the community channels as soon as they’re available.

You can also register to join the additional events that are organized along BazelCon -

- **[BazelCon 2024 Happy Hour:](https://docs.google.com/forms/d/e/1FAIpQLSfC2xsAad-7w5TQ5PY6I1VIZD5lSfAQ54U13pxVNr30F1jBVQ/viewform)** Google Cloud and BuildBuddy are co-hosting a BazelCon Happy Hour on Monday, October 14th. The Happy Hour begins at 7:30 PM and is just across the street from BazelCon!
- **[Post-BazelCon Game Night Mixer:](https://docs.google.com/forms/d/e/1FAIpQLSfS6Y-vNTTblQEsUq2dgcvscSG9wJTMoBSe8SzthM1uF66W5Q/viewform)** EngFlow, JetBrains, and LinkedIn are organizing an after party on Tuesday, October 15th at 6 PM. Great way to relax after the conference over games, food and drinks.
- **[Bay Area Build Meetup:](https://docs.google.com/forms/d/e/1FAIpQLSex7cHtqULL5_QzSSJRuVUwEKvTuCR6HEC8Os9MqfTln3qiyA/viewform)** Hosted by EngFlow and Meta, a Build meetup will be held at the Meta Campus on Wednesday, October 16th, from 9 AM - 6 PM. Hands-on sessions with contributors to Buck2, Bazel, CMake, and more ending in a Happy Hour!

We hope you enjoy and have fun at BazelCon!

### Transfer of community maintained repositories to _bazel-contrib_

The Google Bazel team is migrating community-maintained repositories from the _bazelbuild_ GitHub organization to the _bazel-contrib_ organization. This move aims to provide better maintenance and support for these projects. The _bazel-contrib_ organization is governed by the Bazel Rules Author SIG and supported by the community, ensuring the continued development and health of these valuable resources. Take a look at this [GitHub discussion](https://github.com/orgs/bazelbuild/discussions/2) for more details.

## Product updates

### Releases

Bazel [7.3.0](https://github.com/bazelbuild/bazel/releases/tag/7.3.0) was released in Q3 ‘24, along with patch releases [7.3.1](https://github.com/bazelbuild/bazel/releases/tag/7.3.1) and [7.3.2](https://github.com/bazelbuild/bazel/releases/tag/7.3.2).

Bazel [7.4.0](https://github.com/bazelbuild/bazel/issues/23271) is in progress and scheduled to be released in October. The first release candidate is being prepared. 

Bazel 8.0 is coming soon! The [first release candidate](https://github.com/bazelbuild/bazel/releases/tag/8.0.0rc1) is already out, so please take a moment to test and report any issues you find in the [Bazel repository](https://github.com/bazelbuild/bazel/issues/new?assignees=sgowroji%2Ciancha1992%2Csatyanandak&labels=type%3A+bug%2Cuntriaged&projects=&template=bug_report.yml). The final release is tentatively expected around October 28th. Keep this date in mind as you plan and prioritize contributions. Stay updated on any changes by following the [release tracker issue](https://github.com/bazelbuild/bazel/issues/23315).

### Celebrating 1 million IntelliJ Bazel plugin downloads

We're thrilled to announce a major milestone for the IntelliJ Bazel plugin: **1 million downloads**! 🎉
This achievement is a testament to the hard work, dedication, and incredible support from our community. Thank you to all of our users for your continued trust and support. Your feedback and contributions have been invaluable in shaping the plugin into what it is today.

## Community corner

- [Bazel Overlay Pattern](https://fzakaria.com/2024/08/29/bazel-overlay-pattern.html) _by Farid Zakaria_
- [Migrating to Bazel Modules (a.k.a. Bzlmod)](https://blog.engflow.com/2024/06/27/migrating-to-bazel-modules-aka-bzlmod---the-easy-parts/) series _by Mike Bland_
- [Around the World with Bazel in Watercolors](https://blog.engflow.com/2024/08/08/around-the-world-with-bazel-in-watercolors/) series _by Helen Altshuler_
- [Birth of the Bazel](https://blog.engflow.com/2024/10/01/birth-of-the-bazel/) _by Han-Wen Nienhuys_
- [Bazel Knowledge: reproducible outputs](https://fzakaria.com/2024/09/26/bazel-knowledge-reproducible-outputs.html) _by Farid Zakaria_
- Aspect Insights aka Bazel Podcast is now on Spotify and Apple Podcasts, with the latest episode being a sit down with _Fabian Meumertzheim_ titled [Navigating BzlMod: Migrating to Bazel 8 and Beyond](https://open.spotify.com/show/00scj8eaBhgi08eJEe7MSf) and a conversation with _Ed Schouten_ on [Buildbarn’s Evolution and Impact](https://open.spotify.com/episode/0IFFd89a6BFm5bvapLcQzk)

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

_*Copyright © 2024 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
