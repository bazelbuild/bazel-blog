---
layout: posts
title: "Announcing Bazel Long Term Support (LTS) releases"
authors:
  - aiuto
  - hicksjoseph
  - philwo
---

# Announcing Bazel Long Term Support (LTS) releases

tl;dr Bazel will now provide Long Term Support (LTS) Releases as well as regular rolling releases.

Similar to other Open Source products, many current and future Bazel users require a stable, supported release of Bazel where the behavior doesn’t regularly change, but which receives critical bug fixes and security patches. At the same time, other Bazel users prefer frequent, high quality updates with small, incremental features delivered regularly.

We are pleased to announce that, starting with the next major release (4.0), Bazel will provide Long Term Support (LTS) releases as well as regular Rolling releases.

Here is an example timeline:

![example LTS timeline](/assets/lts_timeline.png)

Some benefits of this new release cadence are:
- Bazel will release stable, supported LTS releases on a predictable schedule with a long window without breaking changes
- Bazel contributors / rules owners can prepare to support future LTS releases via rolling releases.
- Bazel users can choose the release cadence that works best for them, since we will offer both LTS releases and rolling releases.

Long Term Support (LTS) releases:
- We will create an LTS release every ~9 months resulting in a new LTS release branch and an increment to the major version number.
- Each LTS release will include all new features, bug fixes and (breaking) changes since the last major version.
- Bazel will actively support each LTS branch for 9 months with critical bug fixes, but no new features.
- Thereafter, Bazel will provide maintenance for two additional years with only security and OS compatibility fixes.
- Bazel Federation reboot: Bazel will provide strong guidance about the ruleset versions that should be used with each Bazel release so that each user will not have to manage interoperability themselves.

Rolling releases:
- Live-at-head approach, which reduces upgrade distance and cost.
- Continuous delivery of Bazel versions, in sync with Google’s internal Blaze releases.
- Must pass Google’s internal test suite and be green on Bazel CI (external).
- Bazel's main branch will form the basis for rolling releases.
- Incompatible flags will still be used to ease the burden of migrating to new functionality, but default behaviors may change with any rolling release.

If you have questions or concerns, feel free to reach out to us:

- Informational Q&A at BazelCon 2020
- Discussion: bazel-discuss@google.com.

Thanks,

Joe Hicks, Tony Aiuto, and Philipp Wollermann (on behalf of Bazel team)
