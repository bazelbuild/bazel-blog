---
layout: posts
title: "Bazel Reaches 1.0 Milestone"
authors:
  - dslomov
---

_[Crossposted from Google Open Source Blog](https://opensource.googleblog.com/2019/10/bazel-reaches-10-milestone.html)_


We're excited to announce the first General Availability release of [Bazel](http://bazel.build), an [open source](https://github.com/bazelbuild/bazel) build system designed to support a wide variety of programming languages and platforms.

Bazel was born of Google's own needs for highly scalable builds. When we [open sourced Bazel back in 2015](https://opensource.googleblog.com/2015/09/building-build-system-bazel-reaches-beta.html), we hoped that Bazel could fulfill similar needs in the software development industry. A growing [list of Bazel users](https://github.com/bazelbuild/bazel/wiki/Bazel-Users) attests to the widespread demand for scalable, reproducible, and multi-lingual builds. Bazel helps Google be more open too: several large Google open source projects, such as Angular and TensorFlow, use Bazel. Users have reported [3x test time reductions](https://databricks.com/blog/2019/07/23/fast-parallel-testing-at-databricks-with-bazel.html)  and [10x faster](https://redfin.engineering/we-switched-from-maven-to-bazel-and-builds-got-10x-faster-b265a7845854) build speeds after switching to Bazel.

With the 1.0 release we’re continuing to implement Bazel's [vision](https://docs.bazel.build/versions/master/bazel-vision.html):



*   Bazel builds are **fast and correct**. Every build and test run is incremental, on your developers’ machines and on your [CI](https://en.wikipedia.org/wiki/Continuous_integration) test system.
*   Bazel supports **multi-language, multi-platform** builds and tests. You can run a single command to build and test your entire source tree, no matter which combination of languages and platforms you target.
*   Bazel provides a **uniform extension language, Starlark,** to define builds for any language or platform.
*   Bazel works across **all major development platforms** (Linux, macOS, and Windows).
*   Bazel allows your builds **to scale**—it connects to distributed remote execution and caching services. 

The key features of the 1.0 GA release are:



*   **Semantic Versioning**

    Starting with Bazel 1.0, we will use [semantic versioning](https://blog.bazel.build/2019/06/06/Bazel-Semantic-Versioning.html) for all Bazel releases. For example, all 1.x releases will be backwards-compatible with Bazel 1.0. We will have a window of at least three months between major (breaking) releases. We'll continue to publish minor releases of Bazel every month, cutting from GitHub HEAD.

*   **Long-Term Support**

    Long-Term Support (LTS) releases give users confidence that the Bazel team has the capacity and the process to quickly and safely deliver fixes for critical bugs, including vulnerabilities.

*   **Well-rounded features for Angular, Android, Java, and C++**

    The new features include end-to-end support for remote execution and caching, and support for standard package managers and third-party dependencies.


New to Bazel? Try the [tutorial](https://docs.bazel.build/versions/1.0.0/getting-started.html) for your favorite language to get started. 

With the 1.0 release we still have many exciting developments ahead of us. Follow our [blog](https://blog.bazel.build) or [Twitter account](https://twitter.com/bazelbuild) for regular updates.  Feel free to contact us with questions or feedback on the [mailing list](https://groups.google.com/forum/#!forum/bazel-discuss),  submit feature requests (and report bugs) in our [GitHub issue tracker](https://github.com/bazelbuild/bazel/issues), and join our [Slack channel](https://slack.bazel.build/). Finally, join us at the largest-ever [BazelCon](https://events.withgoogle.com/bazelcon-2019/) conference in December 2019 for an opportunity to meet other Bazel users and the Bazel team at Google, see demos and tech talks, and learn more about fast, correct, and large-scale builds.

 

Last but not least, we wouldn't have gotten here without the continued trust, support, encouragement, and feedback from the community of Bazel users and contributors. Heartfelt thanks to all of you from the Bazel team!  
