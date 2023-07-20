---
layout: posts
title: "Bazel Q2 2023 Community Update"
authors:
 - keertk
 - radvani
---

## Product updates

### Feature improvements

**Bisect feature in Bazelisk:** The `--bisect` flag was introduced in [Bazelisk v1.17.0](https://github.com/bazelbuild/bazelisk/releases/tag/v1.17.0). It allows you to bisect Bazel versions to find out the specific commit that caused a build failure. You can find more information and examples [here](https://github.com/bazelbuild/bazelisk#--bisect).

**Lockfile for Bzlmod:** Preliminary support for a lockfile for Bzlmod was introduced in [Bazel 6.2.0](https://github.com/bazelbuild/bazel/releases/tag/6.2.0). It's disabled by default; use [--lockfile_mode](https://bazel.build/reference/command-line-reference#flag--lockfile_mode)=update to enable it. The lockfile contains only Bazel module information; it does not involve module extensions yet.

**Build without the Bytes:** BwoB is now enabled by default at HEAD. Many improvements landed that make BwoB just work e.g. Symlinks and remote cache eviction are supported. Use [--experimental_remote_cache_eviction_retries](https://bazel.build/reference/command-line-reference#flag--experimental_remote_cache_eviction_retries) to let Bazel automatically retry the build when cache eviction happens during the build.

### Releases

[Bazel 6.2.0](https://github.com/bazelbuild/bazel/releases/tag/6.2.0) and [6.2.1](https://github.com/bazelbuild/bazel/releases/tag/6.2.1) were released in Q2 ‘23. Bazel 6.3.0 is currently in the works and scheduled to be released in July. Please follow the release tracker [issue](https://github.com/bazelbuild/bazel/issues/18368) for status updates.

We are also working towards [Bazel 7.0.0](https://github.com/bazelbuild/bazel/issues/18548) and plan to create the first release candidate before BazelCon.

### Android Rules updates

We would like to inform you of  changes in rules_android branches. Development has moved from the "[pre-alpha](https://github.com/bazelbuild/rules_android/tree/pre-alpha)" branch to a new branch called "[main](https://github.com/bazelbuild/rules_android/tree/main)" with the same structure as "pre-alpha". 

Possible actions for users:

1. For those who are already using rules_android's pre-alpha branch, we encourage you to use the “main” branch, since we will continue to update Starlark implementations of Android rules there. Please modify any code import or automation pipelines to use the new branch.
2. For those who are still using the built-in Android rules from Bazel or rules_android master branch, no need for further actions.

This change is part of releasing Starlark Android build rules to open source, and deprecating their Bazel-native equivalents. 

We switched  our internal export pipeline from “pre-alpha” to “main” branch on May 30, 2023, after which the pre-alpha branch will no longer be updated. All future development will occur on the "main" branch, which we anticipate to be the last branch change for this codebase.

## Announcements

### BazelCon 2023

We’re excited to announce that [BazelCon 2023](https://blog.bazel.build/2023/05/25/save-the-date-bazelcon2023.html) will be held October 24-25 in Google Munich! We look forward to further strengthening and connecting the Bazel community.

Call for Proposals is now open! We are looking for proposals for tech talks, lighting talks, and birds of a feather sessions. We encourage proposals from a wide range of speakers, including Bazel users, contributors, and rule authors. Proposals should be submitted through Google Forms:

[https://forms.gle/y3w1nfZdzDB2Rm498](https://forms.gle/y3w1nfZdzDB2Rm498)

The CFP will close on July 31, 2023, so we recommend that you submit your proposal early. Following the closure, all submissions will be reviewed by our program committee, and we'll notify all applicants once the reviews are complete.

### Bazel examples

Through our CSAT survey, we learnt that a lack of good examples and tutorials is a big pain point for most Bazel users. Please fill out the poll and share your thoughts [here](https://github.com/bazelbuild/bazel/discussions/18709) to help us improve and target top examples.

### Bazel Product Partner program

We are very happy to announce that the [Bazel Product Partner program](https://bazel.build/community/partners) is now live! With this program, we aim to recognize organizations that are improving the Bazel developer experience by adding tools or services that integrate with Bazel. Read more about it in our [blog post](https://blog.bazel.build/2023/07/19/bazel-partner.html).

### Explainer video

To continue to grow and educate new users, we launched a new Bazel explainer video: [What is Bazel?](https://www.youtube.com/watch?v=fSxOZSFph4g) 
Please share this with your engineering community to drive adoption of Bazel.

## Highlights

### Release cadence survey results

In Q1, we sent out a survey to collect feedback on the Bazel LTS release cadence in order to determine the best path forward for the community.

Based on the [survey results](https://github.com/bazelbuild/bazel/discussions/18144), we are keeping the current de facto 12-month LTS release cycle and continuing to ship minor releases for the latest LTS release every two months to backport backwards-compatible bug fixes and new features requested by the community.

Please take a look at the [release model](https://bazel.build/release) and [best practices](https://bazel.build/release/rule-compatibility) for rules authors to keep compatibility with Bazel.

### Contributor metrics

In Q2, we received 256 new PRs, of which 203 were reviewed and accepted/closed. We also received 326 new issues, of which 135 were bugs and 69 were feature requests.

![Image](/assets/blog-bazel-q2-2023-contributor-metrics.png)

## Community corner

This is a space for the Bazel community voice. If there is anything interesting you are building or any updates you would like to highlight in future editions, please reach out to product@bazel.build.

- [Bazel Community Day – San Francisco](https://www.engflow.com/blog/2023-06-01)
- [Introducing rules_oci](https://security.googleblog.com/2023/05/introducing-rulesoci.html)
- [Should I Build My Project with rules_haskell? (Georgi Lyubenov)](https://www.youtube.com/watch?v=8Z2BGTY0W4w)
- [Bazel Tutorial - Building a standalone CLI and GUI with Python](https://www.youtube.com/watch?v=SP0wSks8XPw)
- [Announcing Skyscope](https://www.tweag.io/blog/2023-05-04-announcing-skyscope/)

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

_Copyright © 2023 JetBrains s.r.o. JetBrains and IntelliJ are registered trademarks of JetBrains s.r.o._
