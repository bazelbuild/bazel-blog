---
layout: posts
title: "Bazel Q1 2023 Community Update"
authors:
 - keertk
 - radvani
---

Welcome to the Q1 '23 edition of the Bazel community update! Our goal is to build a stronger community and encourage more participation by keeping you informed on what’s happening in this space.

## Announcements

### Releases

[Bazel 6.1.0](https://github.com/bazelbuild/bazel/releases/tag/6.1.0) was released in March ‘23, along with subsequent patch release [6.1.1](https://github.com/bazelbuild/bazel/releases/tag/6.1.1). We thank community members for their contributions. Bazel 6.2.0 is currently in the works and open for PR submissions. It is scheduled to be released in early June ‘23.

### Bazel Community Experts

The [Bazel Community Experts](https://bazel.build/community/experts) program is an important part of the Bazel ecosystem. It has helped create a thriving community of Bazel build practitioners by providing training and support to partners who collectively employ over 100 Bazel engineers and educate and train over 1,000 engineers with Bazel skills on an annual basis.

Earlier this year, we met with the partners to collect feedback on how to accelerate the program. We were happy to hear the numerous positive impacts of this program and see the collaboration between the partners to help grow the Bazel ecosystem.

In 2023, we plan to expand the program to include product focus partners such as JetBrains* and also make it community managed through a Special Interest Group (SIG). We plan to create a Bazel Marketing SIG in Q2 ‘23 to empower the community to take leadership in building the program along with Google.

We will share more details on the SIG formation and participation in upcoming months. We are excited to see the continued growth of the Bazel community and to work with our partners to make Bazel the best open source build solution.

### BazelCon 2023 and community monthly updates

We are currently planning our 2023 community outreach events and will share more details in Q2 ‘23. We are excited about the growth of community-led meetups to support training and skill development, and we are always happy to join in when possible. Please reach out to product@bazel.build if you would like to discuss how we can help make your event a success.

### Office hours pilot

We have launched dedicated office hours to provide the Bazel team and community experts a forum to engage with users and contributors. This will run as a monthly pilot program on the upcoming dates:

- [April 20th, 11am EST](https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=NGtlbWJoNXUzdHVmaDg4bnE2N29mOGQ5c3QgY184NGJmMzAyNmQ4NmMxNDU2ZjZiMWY5OGZlYzEzN2FhZTljOGFlMDAzMWQxMDkyNWE3ZDIxNjZhMjgzNzEwMTc1QGc&tmsrc=c_84bf3026d86c1456f6b1f98fec137aae9c8ae0031d10925a7d2166a283710175%40group.calendar.google.com)
- [May 25th, 11am EST](https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=Nmh0dWdtaDVpMTlnamFtczVpcWhqaG04OWggY184NGJmMzAyNmQ4NmMxNDU2ZjZiMWY5OGZlYzEzN2FhZTljOGFlMDAzMWQxMDkyNWE3ZDIxNjZhMjgzNzEwMTc1QGc&tmsrc=c_84bf3026d86c1456f6b1f98fec137aae9c8ae0031d10925a7d2166a283710175%40group.calendar.google.com)

You can submit your questions beforehand through [this form](https://docs.google.com/forms/d/e/1FAIpQLSdAmEJN3twWz8Ko25oeXnMDyf4UjDlIw0pJA0esFcQy7rGFug/viewform) and join the live office hours session [here](https://meet.google.com/bbm-dqrv-mws).

## Contribute to a better Bazel

### Release cadence survey

We’re currently collecting feedback on the Bazel LTS release cadence through a [survey](https://forms.gle/sag2mS41qNiGdAFi6). The survey is still open, so please feel free to fill it out. Your feedback will be used to help determine the best release cadence for the Bazel community.

### Platform API improvements

The Configurability team is seeking input on the next steps for improving the Platforms API. Please read the initial [requirements document](https://docs.google.com/document/d/1LD4uj1LJZa98C9ix3LhHntSENZe5KE854FNL5pxGNB4/edit?usp=sharing), add any comments or suggestions, and then fill out a [survey](https://forms.gle/UTG3mjXRBr6RRxsV9) to help the team decide on priorities.

### Documentation contributions 

Last year, we made significant changes to Bazel’s [website](https://bazel.build/) to elevate overall developer experience and make it easier to contribute new content. This year, we aim to further improve Bazel’s documentation and eliminate common pain points. We published a [blog post](https://blog.bazel.build/2023/01/26/call-for-docs-contributions.html) on how you can help support this effort.

## Highlights

### Bazel Day 2023

Bazel Day 2023 was held on March 2 on Google Open Source Live. The following videos are available on-demand:

- **[Intro to Bazel](https://www.youtube.com/watch?v=iPG4-rGptUE) by Radhika Advani and Sven Tiffe:** New to Bazel? Learn how to get started with a quick overview of how Bazel is used, basic concepts, and a demo to build projects with Bazel.
- **[Managing external dependencies with Bzlmod](https://www.youtube.com/watch?v=Jl51QMOTmdg) by Xudong Yang:** Dependencies are part of any build process. With the latest version of Bazel, the process for handling external dependencies has been reworked to better support external and transitive dependencies. This talk introduces Bzlmod and how you can begin to use it with your projects.
- **[Introduction to remote caching and execution with Bazel](https://www.youtube.com/watch?v=QLfx1DkmA8Q) by Chi Wang and Tiago Quelhas:** Did you know you can fast build and test with Bazel's remote caching and remote execution? In this session, you'll learn how to build even faster when building without the bytes.
- **[Bazel IntelliJ plugin](https://www.youtube.com/watch?v=GV_KwWK3Qy8) by Mai Essa:** Walkthrough of the Bazel IntelliJ plugin's features and capabilities.

### Community Day in Israel

Wix Engineering and EngFlow hosted a Bazel Community Day in Israel on February 23. The community gathered for a Bazel newcomers' workshop and a series of talks ranging from Wix's remote execution migration to external dependency management. The following videos are available on-demand:

- **[Keynote](https://www.youtube.com/watch?v=hg8vUHjl0T8) by Helen Altshuler**, CEO and Co-Founder of EngFlow
- **[How Wix migrated from one RBE provider to another with zero downtime](https://www.youtube.com/watch?v=z3AypcHX0Zk) by Zachi Nachshon**, Backend Tech Lead at Wix
- **[Leading EngFlow Bazel workshop: build performance analysis & improvements](https://www.youtube.com/watch?v=O7MtWqQX0QA) by Antonio Di Stefano**, Software Developer at EngFlow
- **[Managing external dependencies with Bzlmod](https://www.youtube.com/watch?v=MB6xxis9gWI) by Xudong Yang**, Software Engineer at Google
- **[Future of Bazel](https://www.youtube.com/watch?v=BnxsO2qf3aI) by Tobias Werth**, Staff Software Engineer at Google

## Product updates

**GitHub archive checksum outage:** On January 30, a change in GitHub's source archive generation mechanism caused build errors for many Bazel users. We have published a [blog post](https://blog.bazel.build/2023/02/15/github-archive-checksum.html) that provides more information about the issue and our recommendations. We would like to thank the community and GitHub product teams for their cooperation in resolving this issue quickly.

**Bazel Central Registry:** BCR was launched in January. As the default Bazel registry for the [Bzlmod](https://bazel.build/versions/6.0.0/build/bzlmod) external dependency system, which entered general availability with Bazel 6.0, the BCR is the recommended place to publish and discover Bazel modules. Find more information in this [blog post](https://blog.bazel.build/2023/01/18/bcr-launch.html).

**Bazel roadmap:** We're thrilled to share our [2023 roadmap](https://bazel.build/about/roadmap)! Our next long term release (LTS), Bazel 7.0, is scheduled for late ‘23. Our focus for 2023 will be on improving the performance, features, and developer experience of Bazel. Some specific goals include:

- Migrating Java and C++ rules to Starlark so they can be developed independently of Bazel LTS release
- Supporting IntelliJ IDEA IDE releases in partnership with JetBrains*
- Making Bazel more user-friendly for Android app builds using the CLI
- Supporting secure supply chain integrity by supporting generation of data required to produce SBOM

We appreciate your feedback. Please check the [roadmap](https://bazel.build/about/roadmap) for regular updates throughout the year.

**Backlog clean up:** Over the past few years, we have noticed several languishing issues and pull requests on repositories across the [Bazel GitHub organization](https://github.com/bazelbuild). Our goal is to close issues/PRs older than 6 months that haven't been addressed and are unlikely to be addressed at the current state, in order to sustainably manage and maintain the growing backlog. More information and implementation details can be found in our [blog post](https://blog.bazel.build/2023/02/24/cleanup-stale-issues.html).

**GitHub Discussions:** The Github Discussions feature has been enabled for the [Bazel project](https://github.com/bazelbuild/bazel/discussions), which provides a new space for our community members to have conversations, ask questions, and share answers, all without the need to open issues. Other channels like [bazel-discuss](https://groups.google.com/g/bazel-discuss) and [bazel-dev](https://groups.google.com/g/bazel-dev) are still available. Please read our [blog post](https://blog.bazel.build/2023/03/16/enable-github-discussion.html) for more information.

## Community corner

This is a space for the Bazel community voice. If there is anything interesting you are building or any updates you would like to highlight in future editions, please reach out to product@bazel.build.

- Uber is [now the official maintainer](https://lists.sr.ht/~motiejus/bazel-zig-cc/%3CCAFVMu-qcAQPHhPb63GWZMTL6E_9ZLTtw4tGcYMQFogXLaDhnAg%40mail.gmail.com%3E#%3CCAFVMu-q=AE_oTBhzy+rwSK-r6reYsxEyYPJbQys=PK9WHuFk1g@mail.gmail.com%3E) for the [bazel-zig-cc rules](https://github.com/uber/bazel-zig-cc), which is heavily used in Uber’s Go monorepo

## Blogs and talks

### Articles

- [Never let a server fall out of sync with a database](https://stairwell.com/news/never-let-a-server-fall-out-of-sync-with-a-database) 
- [Fast and reliable iOS builds with Bazel at Mercari](https://engineering.mercari.com/en/blog/entry/20221215-16cdd59909/)
- [Using Bazel with Vite and Vitest](https://medium.com/@yanirmanor/using-bazel-with-vite-and-vitest-c75b133f4707)
- [Bazel Fundamentals course](https://www.pluralsight.com/courses/bazel-fundamentals)
- [How GitHub's upgrade broke Bazel builds](https://jayconrod.com/posts/127/how-github-s-upgrade-broke-bazel-builds) 
- [Bazel rules to test Bazel rules - Tweag](https://www.tweag.io/blog/2022-10-06-bazel-rules-to-test-bazel-rules/)
- [Introducing rules_xcodeproj 1.0 | BuildBuddy](https://www.buildbuddy.io/blog/introducing-rules_xcodeproj-1-0/) 

### Videos

- [How to make your builds and test extremely fast with Bazel](https://www.youtube.com/watch?v=6MXjAZWmn4Y) 
- [Open source as a driver of innovation | Pioneers in Open Source (interview with Andreas Hermann, rules haskell and rules nixpkgs, Tweag)](https://www.youtube.com/watch?v=lF62EOw8REk) 
- [Bazel tutorial for C++ in 30 minutes](https://www.youtube.com/watch?v=kLLDzLWzuag) 

### Tweets

- [https://twitter.com/sluongng/status/1626312374113210369](https://twitter.com/sluongng/status/1626312374113210369) 
- “I don't remember when was the last time I did a rebuild or clean project. After switching to @bazelbuild these days are long gone.” - [source](https://twitter.com/xbonaventurab/status/1617955097614639104) 

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
| Android app development (charter coming soon)      | Monthly      |   radvani@google.com |
| [Bazel plugin for IntelliJ](https://github.com/bazelbuild/community/tree/main/sigs/bazel-intellij) | Monthly      |    raoarun@google.com |


Interested in learning about SIGs or starting a new one? Find more information on our [website](https://bazel.build/community/sig).

Want to get your SIG listed? Please add it to the [Community repository](https://github.com/bazelbuild/community/tree/main/sigs).

## Ideas, feedback, and submissions are welcome!

Thank you for reading this edition! Let us know if you’d like to see any new information or changes in future community updates by reaching out to product@bazel.build. We look forward to hearing from you.

Thanks,

Google Bazel team

_Copyright © 2022 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
