---
layout: posts
title: "Welcome Android Open Source Project (AOSP) to the Bazel ecosystem"
authors:
  - hicksjoseph
---

After significant investment in understanding how best to build the
Android Platform correctly and quickly, we are pleased to announce that
the Android Platform is migrating from its current build systems (Soong
and Make) to Bazel. While components of Bazel have been [already checked
into the Android Open Source Project (AOSP) source
tree](https://cs.android.com/android/platform/superproject/+/master:build/bazel/),
this will be a phased migration over the next few Android releases
which includes many concrete and digestible milestones to make the
transformation as seamless and easy as possible. There will be no
immediate impact to the Android Platform build workflow or the existing
supported Android Platform Build tools in 2020 or 2021.  Some of the
changes to support Android Platform builds are already in Bazel, such
as Bazel’s ability to parse and execute Ninja files to support a
gradual migration.

Migrating to Bazel will enable AOSP to:

* Provide more flexibility for configuring the AOSP build (better support for conditionals)
* Allow for greater introspection into the AOSP build progress and dependencies
* Enable correct and reproducible (hermetic) AOSP builds
* Introduce a configuration mechanism that will reduce complexity of AOSP builds
* Allow for greater integration of  build and test activities
* Combine all of these to drive significant improvements in build time and experience

The benefits of this migration to the Bazel community are:

* Significant ongoing investment in Bazel to support Android Platform builds
* Expansion of the Bazel ecosystem and community to include, initially, tens of thousands of Android Platform developers and Android handset OEMs and chipset vendors.
* Google’s Bazel rules for building Android apps will be open sourced, used in AOSP, and maintained by Google in partnership with the Android / Bazel community
* Better Bazel support for building Android Apps
* Better rules support for other languages used to build Android Platform (Rust, Java, Python, Go, etc)
* Strong support for [Bazel Long Term Support (LTS) releases](https://blog.bazel.build/2020/11/10/long-term-support-release.html), which benefits the expanded Bazel community
* Improved documentation (tutorials and reference)

The recent check-in of Bazel to AOSP begins an initial pilot phase,
enabling Bazel to be used in place of Ninja as the execution engine to
build AOSP.  Bazel can also explore the AOSP build graph. We're pleased to
be developing this functionality directly in the Bazel and AOSP codebases.
As with most initial development efforts, this work is experimental in
nature. Remember to use the currently supported Android Platform Build
System for all production work.

We believe that these updates to the Android Platform Build System enable
greater developer velocity, productivity, and happiness across the entire
Android Platform ecosystem.

Joe (on behalf of the Bazel and AOSP infrastructure teams)
