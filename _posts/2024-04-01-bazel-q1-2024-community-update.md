---
layout: posts
title: "Bazel Q1 2024 Community Update"
authors:
 - keertk
---

## Announcements

### Developer satisfaction survey

Your feedback matters!

Please take our 5-minute [developer satisfaction survey](https://docs.google.com/forms/d/e/1FAIpQLSdm_kkgnSmB8YkBVNQsjfDtEHflvjwlpzzLIY002tWqXB76YQ/viewform) to help us improve Bazel. No email collection – your input remains anonymous. Thank you in advance for your time!

### Rolling releases

For better visibility of stable LTS releases, rolling releases have been removed from GitHub and are now listed on a [separate page](https://bazel.build/release/rolling). Bazelisk users can still access rolling releases with `USE_BAZEL_VERSION=rolling`.

### LTS release candidates

Starting this quarter, we’re publishing release candidates to [GitHub](https://github.com/bazelbuild/bazel/releases) along with final LTS releases.

For more information on our release model, cadence, and differences between rolling and LTS releases, please refer to our [documentation](https://bazel.build/release).

### Bazel 4 is deprecated

Support for Bazel 4 has ended. We'll no longer backport critical fixes for security or OS-compatibility. Please consider upgrading to the latest LTS release or using rolling releases.

## Product updates

### Releases

Bazel [7.1.0](https://github.com/bazelbuild/bazel/releases/tag/7.1.0) (along with patch releases [7.1.1](https://github.com/bazelbuild/bazel/releases/tag/7.1.1), [7.0.2](https://github.com/bazelbuild/bazel/releases/tag/7.0.2), and [7.0.1](https://github.com/bazelbuild/bazel/releases/tag/7.0.1)) was released in Q1 ‘24. 

Bazel 7.2.0 is in progress and scheduled to be released in May. Follow the [release tracker issue](https://github.com/bazelbuild/bazel/issues/21774) for updates.

### Bazel plugin for IntelliJ

Take a look at our recent [blog post](https://blog.bazel.build/2024/03/18/intellij-q2-2023-q1-2024-community-update.html) summarizing key changes to the Bazel plugin for IntelliJ from Q2 ‘23 - Q1 ‘24. We discuss the status of `master` vs `google` branches, significant product updates, and more.

### Compact execution log

The Bazel 7.1.0 release introduced a new execution log format. This format, enabled by the `--experimental_execution_log_compact_file` flag, is similar in purpose to the preexisting `--execution_log_{binary,json}_file` formats, but is much cheaper to produce (2% wall time overhead or less) and takes significantly less disk space (a reduction of 100x or more in relation to the old formats). The `//src/tools/execlog:converter` tool can be used to convert between them.

## Community corner

- [LinkedIn Bazel community](https://www.linkedin.com/groups/9137311/)
- [How to migrate an iOS app to Bazel](https://www.buildbuddy.io/blog/how-to-migrate-an-ios-app-to-bazel/)
- [Bazel Bites: A Tasty Metaphor for Streamlined Builds](https://blog.engflow.com/2024/03/28/bazel-bites-a-tasty-metaphor-for-streamlined-builds/)

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
