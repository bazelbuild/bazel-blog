---
layout: posts
title: Bazel Builder Blasts Beyond Beta Barrier
authors:
  - jeffcox
---

_Reposted from [Google's Open Source blog](http://google-opensource.blogspot.com/2015/09/building-build-system-bazel-reaches-beta.html)._

We're excited to announce the Beta release of [Bazel](http://bazel.build), an [open
source](https://github.com/bazelbuild/bazel) build system designed to support a
wide variety of different programming languages and platforms.

There are lots of other build systems out there -- Maven, Gradle, Ant, Make, and
CMake just to name a few. So what's special about Bazel? Bazel is what we use to
build the large majority of software within Google. As such, it has been
designed to handle build problems specific to Google's development environment,
including a massive, shared code repository in which all software is built from
source, a heavy emphasis on automated testing and release processes, and
language and platform diversity. Bazel isn't right for every use case, but we
believe that we're not the only ones facing these kinds of problems and we want
to contribute what we've learned so far to the larger developer community.

Our beta release provides:

* Binary releases for
  [Linux and OS X](https://github.com/bazelbuild/bazel/releases).
* Support for building and testing C++, Java, Python, Rust,
  [and more]({{ site.docs_site_url }}/be/overview.html).
* Support for building Docker images, Android apps, and iOS apps.
* Support for using libraries from
  [Maven, GitHub, and more]({{ site.docs_site_url }}/external.html).
* [A robust API]({{ site.docs_site_url }}/skylark/index.html) for adding your own
  build rules.

Check out the tutorails for working examples using several languages:
* [Build a Java Project]({{ site.docs_site_url }}/tutorial/java.html)
* [Build a C++ Project]({{ site.docs_site_url }}/tutorial/cpp.html)
* [Build an Android App]({{ site.docs_site_url }}/tutorial/android-app.html)
* [Build an iOS App]({{ site.docs_site_url }}/tutorial/ios-app.html)

We still have a long way to go.  Looking ahead towards our 1.0.0 release, we
plan to provide Windows support, distributed caching, and Go support among other
features. See our [roadmap](http://bazel.build/roadmap.html) for more details
and follow our [blog](http://bazel.build/blog) or
[Twitter](https://twitter.com/bazelbuild) account for regular updates.  Feel
free to contact us with questions or feedback on the
[mailing list](https://groups.google.com/forum/#!forum/bazel-discuss) or IRC
(#bazel on freenode).
