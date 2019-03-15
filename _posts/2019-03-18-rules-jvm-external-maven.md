---
layout: posts
title: "A repository rule for calculating transitive Maven dependencies"
authors:
  - jin
  - dkelmer
---

We’re delighted to introduce the initial release of
[`rules_jvm_external`](https://github.com/bazelbuild/rules_jvm_external), a
repository rule to resolve and fetch artifacts transitively in Maven
repositories, like Maven Central and Google Maven. This project is officially
maintained by the Bazel team.

## Background and motivation

Maven integration in Bazel is a large space with many existing robust solutions
from community members:

* [https://github.com/johnynek/bazel-deps](https://github.com/johnynek/bazel-deps)
    * Tool to generate Bazel dependencies transitively for Maven artifacts, with
      Scala and Kotlin support
* [https://github.com/square/bazel\_maven\_repository](https://github.com/square/bazel_maven_repository)
    * Repository rule to create an idiomatic Bazel representation of a Maven
      repository using a pinned list of artifacts, with support for Kotlin and
      Android dependencies
* [https://github.com/menny/mabel](https://github.com/menny/mabel)
    * Tool to generate a Maven dependency graph as a lock file, with support for
      Kotlin and Android dependencies

Each project approaches the problem slightly differently. Check out those
projects as well to see their full feature set and determine which solution
works best for you. It is also possible to wire dependencies up manually using
rules like `java_import_external` and `aar_import_external`.

## Objectives

We wanted to fulfill two primary objectives with `rules_jvm_external`.

The first is that users should be able to run `bazel build //...`. This means
that the calculation of the transitive dependencies and their fetching need to
happen during repository rule execution time. This makes dependency fetching
transparent to users and reduces onboarding friction to a Bazel-built project.

The second is to provide an interface that is familiar to users with projects
that depend on Maven repositories. The specification of artifacts in the
repository rule resembles the specification in the `<dependencies>` tag in a
Maven POM file or the `dependencies` closure in a Gradle build file. In
particular, this means that users only need to specify their direct dependencies
and the rule will handle the rest for them.

## Features and use cases

For the initial release, we are targeting support for Java and Android Java
projects. The following features are supported:

* Supported on Windows, macOS and Linux
* JAR and AAR packaging types
* In-band transitive closure resolution
* Dependency specification directly in the WORKSPACE file
* Custom Maven repositories
* Maven repository authentication with HTTP Basic Authentication
* Artifact version pinning and resolution
* Multiple independent closures of versioned artifacts
    * Not forced to only have one version of an artifact per workspace, although
      different versions are namespaced by the repository name
* Source JAR support
* Dependency exclusion

As part of this, we will no longer be maintaining generate_workspace.
gmaven_rules, which was designed to be an interim solution, will also be
replaced by rules_jvm_external. We will be updating existing documentation to
reflect this over the coming weeks.

## How to use

To start using this project in your Java or Android project, in your WORKSPACE
file, point to the repository rule:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-1.1",
    sha256 = "ade316ec98ba0769bb1189b345d9877de99dd1b1e82f5a649d6ccbcb8da51c1f",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/1.1.zip"
)
```

Then the key components of the rule are to specify your direct dependencies
using the `artifacts` attribute and where those artifacts should come from using
the `repositories` attribute:

```python
load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "maven",
    artifacts = [
        "com.google.guava:guava:27.0-android",
        "androidx.test.espresso:espresso-core:3.1.1",
    ],
    repositories = [
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
    fetch_sources = True,   # Fetch source jars. Defaults to False.
)
```

The `maven_install` rule creates targets you can then depend on in your `BUILD`
files. For example:

```python
android_library(
    name = "foo",
    srcs = ["MyAndroidLib.java"],
    deps = [
        "@maven//:androidx_test_espresso_espresso_core"
        "@maven//:com_google_guava_guava",
    ],
)
```

We have also added a `artifact` helper function to specify the Maven coordinates
directly. For example, the previous example can be written as:

```python

load("@rules_jvm_external//:defs.bzl", "artifact")

android_library(
    name = "foo",
    srcs = ["MyAndroidLib.java"],
    deps = [
        artifact("androidx.test.espresso:espresso-core"),
        artifact("com.google.guava:guava"),
    ],
)
```

## How it works

This rule relies on existing tooling to calculate the transitive closure of
dependencies. The magic underneath is the [Coursier](https://get-coursier.io/)
CLI. There is a thin Starlark wrapper that translates the input from the rule
into a Coursier compatible command line. The CLI returns the calculated
transitive closure of artifacts which the rule parses and uses it to generate
BUILD targets.

## Known Limitations

There are some known limitations for this initial release, like artifact
checksumming and support for Scala and Kotlin-built JARs. We will be addressing
these in the coming releases.

If you have an issue or want to request for a feature, please [file an
issue](https://github.com/bazelbuild/rules_jvm_external/) on the repository.
