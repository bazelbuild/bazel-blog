---
layout: posts
title: The New World of Bazel Releases
---

Bazel has been open-sourced exactly [2.5 years ago](https://blog.bazel.build/2015/03/27/Hello-World.html). It continues to be quite a journey, and we are very happy we have acquired some fellow travellers: [many projects, organizations and companies that we all know and love](https://github.com/bazelbuild/bazel/wiki/Bazel-Users) rely on Bazel every day.

As our community grows, we owe to it a transparent and predictable release process. So we are
taking some steps to bring more clarity and order to the world of Bazel releases:

 * We will cut (from [master](https://github.com/bazelbuild/bazel/tree/master)) a candidate for 
   *minor releases* (0.7, 0.8 and so on) **every month** 
   on approximately first business day of the month. The planned target dates for
   the cuts are published [as GitHub issues with label 'release'](https://github.com/bazelbuild/bazel/issues?q=label%3Arelease%20)
 * After the release candidate is cut, we will let it bake for *two weeks* before promoting it 
   to the release. We will cherry-pick fixes for critical bugs, issuing new release candidates
   (0.7.0rc1, 0.7.0rc2 and so on), and release 0._minor_.0 version at the end of baking period.
 * If critical bugs are discovered after the release, we will fix them and issue *patch releases*
   as needed (0.7.1, 0.7.2 and so on). Patch releases are always patches on top of existing minor 
   releases - they are never cut from master.
 * No new features or backward incompatible changes ever appear in patch releases, and no new
   features or backward incompatible changes are added to release candidates after they have been cut.
   
Our website has more details on [release policy](https://bazel.build/support.html#releases).

As a result of this change, we now issue one minor release per month.

Our [roadmap](https://bazel.build/roadmap.html) reflects our vision for Bazel 1.0 and beyond. We will
annotate features on the roadmap with the release versions as those features get shipped.

_By [Dmitry Lomov](https://github.com/dslomov)_
