---
layout: posts
title: "Scalable Android Builds with Incremental Dexing"
---

Bazel supports building Android apps with Java and C++ code out of the box through the
[`android_binary`](https://docs.bazel.build/versions/master/be/android.html#android_binary)
rule and related rules.  Android binary builds need a lot of machinery--more than we can cover in a
blog post.  However, one aspect that’s fairly important to Bazel’s Android support is scalability.
That’s because we build most of Google’s own Android apps with Bazel and those apps are not only
comparably large but also come with hundreds of engineers that want to build and test their changes
quickly.

For over a year now, Bazel has used a feature we call __incremental dexing__ to speed up Android
builds.  As the name implies, incremental dexing is designed to minimize the work needed to rebuild
an app after code changes, but it also parallelizes builds and lets them scale better to the needs
of Google’s own apps.  But how does it work and what is "dexing" anyway?

Dexing is what we call the build step that converts Java bytecode to Android's .dex file format.
Traditionally, that’s been done for an entire app at once by a tool fittingly called "dx".  Even
if only a single class changed, dx would reprocess the entire app, which could take a while.
But dx really has two jobs: compile bytecode to corresponding .dex code, and merge all the classes
that are going into the app into as few .dex files as possible.  The latter is needed because while
Java bytecode uses a separate file per class, a single .dex file can contain thousands of classes.
But because of the differences in instruction encoding, the compilation step is the more
time-consuming one, while merging can be done separately and relatively quickly even for large apps.

Incremental dexing, as you might have guessed, separates bytecode compilation and dex merging.
Specifically, it runs the compilation step separately in parallel for each .jar file that’s part of
the app’s runtime classpath.  To arrive at a final app, Bazel then merges the compilation results
from each .jar.

How does that help?  In a number of ways:
1. We can take advantage of the parallelism inherent in the build and farm out compilation to as
   many processes as there are .jars in the app.
2. When rebuilding after making code changes, we only have to recompile the .jars that changed,
   avoiding potentially a whole lot of work that doesn’t change the output.
3. We can re-use compilation results in cases where the same .jar is part of multiple apps (for
   example, common libraries or just to build test inputs).
4. We can also parallelize other build steps that are needed as inputs for the merge step.
5. With the `--experimental_spawn_scheduler` flag, it simplifies caching past dexing results
   (for example, when one class in a large .jar changes).
6. Most importantly, this strategy scales much better for large apps.

What we mean by scalability is that the total number of classes in the app matters much less for
how long it takes to build the app. This is especially important when rebuilding the app after
small changes: with incremental dexing, the time spent on dexing is proportional to the size of
the change.  Previously, dexing time was always proportional to the number of classes in the app,
no matter the change.  This scalability has been critical in keeping up with our ever-growing apps.

One prerequisite for taking full advantage of incremental dexing is to split up the app into
multiple, ideally small, .jars.  Bazel naturally encourages and enables this with the
[`java_library`](https://docs.bazel.build/versions/master/be/java.html#java_library)
and
[`android_library`](https://docs.bazel.build/versions/master/be/android.html#android_library)
rules, which build .jar files from a set of Java sources, conventionally for a single Java package
at a time.  Third-party libraries are also often distributed as .jar or .aar files that Bazel
ingests with the
[`java_import`](https://docs.bazel.build/versions/master/be/java.html#java_import)
and
[`aar_import`](https://docs.bazel.build/versions/master/be/android.html#aar_import)
rules.

Tooling-wise it was reasonably straightforward to separate the merging step because Android
provides a tool called dexmerger for just this purpose and compiling separately more or less just
means running dx on one class at a time.  One wrinkle for now is that dexmerger creates final .dex
files that are larger than necessary.  That means you want to turn off incremental dexing when
you’re building a binary that you want to give to users, but it can speed up your development and
test builds every day with no known adverse effect.  Plus, we expect this to get better since
Android Studio has started to use a similar scheme to build Android apps in Gradle.
