---
layout: posts
title: "Announcing Bazel Long Term Support (LTS) releases"
authors:
  - aiuto
  - hicksjoseph
  - philwo
---

**tl;dr Bazel will now provide Long Term Support (LTS) Releases as well as regular rolling releases.**

Similar to other Open Source products, many current and future Bazel users require a stable, supported release of Bazel where the behavior doesn’t regularly change, but which receives critical bug fixes and security patches. At the same time, other Bazel users prefer frequent, high quality updates with small, incremental features delivered regularly.

We are pleased to announce that, starting with the next major release ([4.0](/2020/11/10/bazel-4.0-announce.html)), Bazel will provide Long Term Support (LTS) releases as well as regular Rolling releases.

Here is an example timeline:

![example LTS timeline](/assets/lts_timeline.png)

Some benefits of this new release cadence are:

* Bazel will release stable, supported LTS releases on a predictable schedule with a long window without breaking changes
* Bazel contributors and rules owners can prepare to support future LTS releases with rolling releases.
* Bazel users can choose the release cadence that works best for them between LTS releases and rolling releases. 

Long Term Support (LTS) releases:

* Bazel creates an LTS release every ~9 months resulting in a new LTS release branch and an increment to the major version number.
* Each LTS release includes all new features, bug fixes, and (breaking) changes since the last major version.
* Bazel supports each LTS branch for 9 months with critical bug fixes, but no new features.
* Thereafter, Bazel provides two years of maintenance, with only security and OS compatibility fixes.
* Bazel Federation reboot: Bazel provides guidance about the ruleset versions that should be used with each Bazel release so that each user will not have to manage interoperability themselves.

Rolling releases:

* Live-at-head approach, which reduces upgrade distance and cost.
* Continuous delivery of Bazel versions, in sync with Google’s internal Blaze releases.
* Must pass Google’s internal test suite and be green on Bazel CI.
* Bazel's main branch forms the basis for rolling releases.
* [Incompatible flags](https://docs.bazel.build/versions/master/backward-compatibility.html) will still be used to ease the burden of migrating to new functionality, but default behaviors may change with any rolling release.

If you have questions or concerns, feel free to reach out to us: [bazel-discuss@googlegroups.com](mailto:bazel-discuss@googlegroups.com).

Thanks,

Joe Hicks, Tony Aiuto, and Philipp Wollermann (on behalf of Bazel team)
