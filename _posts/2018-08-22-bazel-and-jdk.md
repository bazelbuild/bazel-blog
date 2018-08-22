---
layout: posts
title: "Bazel and the JDK"
authors:
  - buchgr
---

Bazel is written in Java and our releases have shipped with a JDK embedded in
the binary for a while now. This is so that users do not need to separately
install a JDK just to run Bazel. 

The JDK is a large piece of software by any measure, and most notably so in
binary size. Azul Zulu 8 is about 80 MiB in size. Due to the large size of the
JDK we have been exposing Bazel's JDK to users of rules for JVM languages - so
that these users would not need two full JDKs. In more technical terms the
embedded JDK is currently the default
[java_runtime](https://docs.bazel.build/versions/master/be/java.html#java_runtime)
, if no system JDK is installed, for the following three Bazel flags:

- _startup [--server_javabase](https://docs.bazel.build/versions/master/user-manual.html#startup_flag--server_javabase)_
This is the JDK that Bazel runs on.
- _[--host_javabase](https://docs.bazel.build/versions/master/user-manual.html#flag--host_javabase)_
This is the JDK that JVM-based tools (e.g. javac, JavaBuilder, scalac, etc.)
run on.
- _[--javabase](https://docs.bazel.build/versions/master/user-manual.html#flag--javabase)_
The JDK Java used for bazel run, bazel test, and for Java binaries built by
[java_binary](https://docs.bazel.build/versions/master/be/java.html#java_binary)
and [java_test](https://docs.bazel.build/versions/master/be/java.html#java_test)
rules.

However supporting development on the embedded JDK becomes more and more
problematic going forward. So in a future release of Bazel we plan to make the
embedded JDK invisible to users of Bazel and only use it to run Bazel itself
(for the _--server_javabase_). Key benefits of that are:
* With the arrival of modularization in JDK 9, there is a possibility to
drastically reduce the size of Java runtime required to run Bazel, and so
make Bazel installation much smaller. We found that Bazel only needs a handful
of JDK modules and using [jlink](https://docs.oracle.com/javase/9/tools/jlink.htm)
we can build a JDK that's only 13 MiB in size. That way everyone gets a smaller
Bazel binary and users who don't develop for the JDK don't need to pay the full
cost of it.
* Even for users building JVM languages, it makes sense to have full control and
transparency of which JDK they build with, and not rely on a particular version
of a JDK supplied with Bazel. We want to be able to upgrade the version of the
JDK at its own pace and without breaking users whose applications might not be
compatible with the version that Bazel uses.

Users will have to provide their own JDK for the _--host_javabase_ and the
_--javabase_. We plan to make these changes around the time Bazel 0.19.0 is
being released and will do a more detailed announcement in the near future.
