---
layout: posts
title: "Bazel Q3 2023 Community Update"
authors:
 - keertk
---

## Announcements

### BazelCon 2023

[BazelCon ‘23](https://rsvp.withgoogle.com/events/bazelcon2023/home) is fast approaching! We look forward to connecting with the Bazel community at this year’s hybrid event in which we’ll showcase interesting talks, share the Bazel State-of-the-Union, provide opportunities to collaborate with peers, and have a live Q&A with the Bazel team.

A few updates:

- The [preliminary schedule](https://rsvp.withgoogle.com/events/bazelcon2023) is now available. We'll update this page with speaker information and other details soon. Thank you to everyone who submitted proposals!
- In-person registrations have reached maximum capacity and a waiting list has been opened. Please consider this before booking your trip.
- All main stage talks will be streamed live.
- This year’s Bazel Community Day is co-organized by EngFlow and Tweag, and hosted by Salesforce with happy hour sponsored by Gradle. It is scheduled for Oct 23, a day before BazelCon. [Registration](https://docs.google.com/forms/d/e/1FAIpQLSe9kzK0yryGVhw2CjakT2fNh2YVim5H7ZvqRpdTSETcwUQ8ag/viewform) is open.

If you have any questions, please reach out to bazelcon-planning@google.com.

## Product updates

### Releases

Bazel [6.3.0](https://github.com/bazelbuild/bazel/releases/tag/6.3.0) (along with patch releases [6.3.2](https://github.com/bazelbuild/bazel/releases/tag/6.3.2) and [6.3.1](https://github.com/bazelbuild/bazel/releases/tag/6.3.1)) were released in Q3 ‘23. 

Bazel [6.4.0](https://github.com/bazelbuild/bazel/issues/19035) is in progress and scheduled to be released in early October. The first release candidate is already out and ready for testing.

We’re continuing to work towards Bazel 7.0 with the first release candidate tentatively scheduled for Oct 17 and the final release tentatively scheduled for Nov 17. Please keep these dates in mind as you plan and prioritize contributions. Follow the [release tracker issue](https://github.com/bazelbuild/bazel/issues/18548) for updates.

### Bzlmod: a call for migration

Since the official launch of Bzlmod in Bazel 6.0 in Dec ‘22, the team has been hard at work improving Bzlmod in time for enabling it by default in Bazel 7.0. Read [this blog post](https://blog.bazel.build/2023/07/24/whats-new-with-bzlmod.html) for details on what's changed since 6.0, what's coming up in 7.0, and a roadmap for the next few years.

We'd like to encourage you to use Bzlmod by default in new projects, and start migration for existing projects. Please respond to [this poll](https://github.com/bazelbuild/bazel/discussions/18329) to help us understand which rule sets and libraries are most important to unblock your migration.

 If you have any questions or would like support with this process, feel free to email bazel-discuss@googlegroups.com, start a [GitHub discussion](https://github.com/bazelbuild/bazel/discussions/new/choose), or post on the #bzlmod channel on [Slack](https://slack.bazel.build/).

### Lockfile improvements

Since Bazel 6.2.0, we’ve made the following improvements to the lockfile feature:

- A new attribute `environ` is added to `module_extension` to allow depending on environment variables.
- The module extension will now be re-evaluated in response to changes in the files it depends on.
- Lockfile version bumps will prompt users to refresh it in `--lockfile_mode=update`.
- New attributes `os_dependent` and `arch_dependent` are added to `module_extension` to signify its reliance on the operating system or system architecture. When either or both of these attributes are true, separate module extensions will be stored in the lockfile for each distinct combination of operating system and architecture.

### Build without the Bytes enabled by default in Bazel 7

We recently turned on Build without the Bytes by default, and the first release to include this change will be Bazel 7.0. Read [this blog post](https://blog.bazel.build/2023/10/06/bwob-in-bazel-7.html) for more details.

The improvements made have already landed in [last_green](https://github.com/bazelbuild/bazelisk) and recent [rolling releases](https://github.com/bazelbuild/bazel/releases). Please test them with your projects and report back any issues you encounter. Your help is appreciated!

### Removing unused flags

We have started the process of removing and cleaning up unused flags. Refer to this [GitHub discussion](https://github.com/bazelbuild/bazel/discussions/19296) for more details and reach out if you have any questions or concerns.

## Community corner

- [Introducing rules_gradle](https://github.com/sgammon/rules_gradle)
- [Introducing rules_graalvm](https://github.com/sgammon/rules_graalvm)
- [Upcoming events hosted by the build community](https://www.engflow.com/buildCommunityEvents)

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
