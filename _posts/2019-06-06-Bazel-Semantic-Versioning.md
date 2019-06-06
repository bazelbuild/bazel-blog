---
layout: posts
title: Bazel Stability and Semantic Versioning
authors:
  - dslomov
---

It's been 4 years since we [open-sourced Bazel](https://blog.bazel.build/2015/03/27/Hello-World.html).
We've come a long way. Many companies and open-source projects now benefit from fast, correct, multilingual,
scalable builds with Bazel. 

One of the user concerns we hear most frequently is that our rate of breaking changes is too high.
Over the last year we've been working to make sure we
[manage](https://docs.google.com/document/d/1Dj5PBLmPVg9ZyApm4GobM3y-mDgY3mVaqpRVttOe-ZQ/)
breaking changes by following the
[incompatible change policy](https://docs.bazel.build/versions/0.25.0/backward-compatibility.html)
, providing the community with migration tools such as 
[`bazelisk --migrate`](https://github.com/bazelbuild/bazelisk#other-features),
and maintaining an [incompatible change pipeline](https://buildkite.com/bazel/bazelisk-plus-incompatible-flags/builds) 
on our CI to assess the impact of incompatible changes on a representative set of projects. 
However, so far every Bazel release has had incompatible changes.

We're now ready to enter a new phase of Bazel's evolution. 
[Bazel release 0.27](https://github.com/bazelbuild/bazel/issues/7816) (June 2019) 
_will have a stability window of 3 months:_ we will not make any breaking changes (flip any `--incompatible_*` flags)
in releases [0.28](https://github.com/bazelbuild/bazel/issues/8571) (July 2019)
and [0.29](https://github.com/bazelbuild/bazel/issues/8572) (August 2019).

The September 2019 release will be the [Bazel 1.0](https://github.com/bazelbuild/bazel/issues/8573) release.
After that release, we'll continue following [semantic versioning](https://semver.org/)
in naming Bazel releases: 1.x releases will be backwards-compatible with Bazel 1.0.
We'll continue to publish minor releases of Bazel every month, cutting from GitHub HEAD.
We'll maintain at least three-month stability windows between Bazel major (backward-incompatible) releases.
This [design document](https://docs.google.com/document/d/1NCKLVwYMMp7Wjpb4-49FuVCWmQci6i4WZQVvm3u-WcI/) explains more.

Besides being a stability milestone, Bazel 1.0 is a milestone in the delivery of the [Bazel
vision](https://docs.bazel.build/versions/master/bazel-vision.html).
We will be sharing more about Bazel 1.0 in the near future. 

We thank you, the Bazel community, for your continued trust, contributions, encouragement, and feedback!
Your input has been critical to the Bazel journey and it will be indispensable in the future—please keep it coming!
