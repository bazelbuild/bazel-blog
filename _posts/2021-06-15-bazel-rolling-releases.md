---
layout: posts
title: "Bazel rolling releases"
authors:
  - fwe
---

**tl:dr Bazel rolling releases are now available **

As previously [announced](https://blog.bazel.build/2020/11/10/long-term-support-release.html), Bazel has been migrating to a two-track release model to better address the different needs of our users. 

Roughly every nine months, we’ll publish a stable LTS release that has been thoroughly tested against downstream projects, and which will receive critical security and bug fixes afterwards.

For those of you who want to live closer to HEAD, we’re offering rolling releases. These weekly releases are tested on Bazel's test suite on Bazel CI and Google’s internal test suite. Where possible, incompatible flags will still be used to ease the burden of migrating to new functionality, but default behaviors may change with any rolling release. (You can also use rolling releases to preview the next LTS version. For example, 5.0.0-pre.20210604.6 is based on a candidate cut on 2021-06-04 and represents a milestone towards the 5.0 LTS release.)

While the [first LTS release](https://blog.bazel.build/2021/01/19/bazel-4-0.html) has been available since January, I’m very happy to announce that rolling releases are now available. 

You can download the latest rolling release (5.0.0-pre.20210604.6) from [GitHub](https://github.com/bazelbuild/bazel/releases/tag/5.0.0-pre.20210604.6) and [our releases website](https://releases.bazel.build/5.0.0/rolling/5.0.0-pre.20210604.6/index.html). Alternatively you can use [Bazelisk v1.9.0](https://github.com/bazelbuild/bazelisk/releases/tag/v1.9.0) (or later), which supports rolling releases, too. You can set up Bazelisk to use a specific version name or the “rolling” identifier, which uses the most recent rolling release. For more details, see the [Bazelisk documentation](https://github.com/bazelbuild/bazelisk#how-does-bazelisk-know-which-bazel-version-to-run).

We’re still working on polishing some rough edges, especially around documentation. Please let us know if you have feedback - simply reply to the [announcement in bazel-discuss](https://groups.google.com/g/bazel-discuss/c/U1UiYxSn5_8) or post to one of the following GitHub issues: [#13505](https://github.com/bazelbuild/bazel/issues/13505) covers rolling releases in general, whereas [#13572](https://github.com/bazelbuild/bazel/issues/13572) is the tracking issue for 5.0.0-pre.20210604.6 in particular.
