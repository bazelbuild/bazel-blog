---
layout: posts
title: Configurable Builds - Part 1
authors:
 - gregestren
---

One of Bazel's long-term goals is to make `$ bazel build //:all` "*just work*"
so that every target builds "the right way", for whatever platform(s) you care
about, using only flags that are genuinely interesting to you. This two-part
series discusses the challenges involved and steps we're taking to get there.

This is a deeper dive into themes covered in Bazel's [configurability roadmap]
(https://bazel.build/roadmaps/configuration.html).

## Motivation

The larger your project gets, the more likely you are to have to build it
different ways.

Maybe you need Android, iOS, and desktop versions of your app. Maybe you build
C++ for different platforms. Or maybe you maintain a popular JavaScript library
that users only want parts of to keep their .js files small.

These are examples of *configuration*: the process of building the same *code*
with different *settings* to customize it for specific needs. In Bazel-speak,
this means building a
[target](https://docs.bazel.build/versions/master/build-ref.html#targets) with
a set of
[flags](https://docs.bazel.build/versions/master/user-manual.html#flags-options):

```sh
$ bazel build //my:cc_binary --cpu=x86
$ bazel build //my:cc_binary --cpu=arm
$ bazel build //my:android_binary --android_sdk=@androidsdk//:sdk-28
```

Bazel's *configurability work* is an ongoing effort to make these tasks simple,
flexible, and powerful. 

## The Problem

Bazel is a
[powerful](https://docs.bazel.build/versions/master/bazel-vision.html) build
tool that's especially suited for large codebases with
[multiple languages](https://blog.bazel.build/2018/12/05/multilanguage-build-system.html).
But it grew out of Google, which historically wrote code for fleets of identical
Linux servers with little need for customization. What customization was needed
was achieved with
[ad hoc flags and logic](https://source.bazel.build/bazel/+/144912e7b7a86b45e07f79e76f6fed20890acb36:src/main/java/com/google/devtools/build/lib/rules/cpp/CppOptions.java;l=258)
built straight into the tool.


This is no longer true inside or outside of Google. Modern software targets
phones, cloud, servers, desktops, [smart
devices](https://en.wikipedia.org/wiki/Smart_device) and more, and must offer
increasingly flexible support for any combination of these platforms.

This means

    $ bazel build //my:binary

isn't enough to describe what you want to do. What platform(s) are you
targeting? What features do you want to include? What if you want to build a
complex app with generated sources, client and server modules, native
extensions, and test data?

Bazel's historical approach of ad hoc flags:

    $ bazel build //my:binary --cpu=arm --crosstool_top=//my:custom_toolchain --define MYFEATURE=1

is lacking in many ways:

1. `--cpu` only accepts values explicitly supported by C++ rules. Even if you're
   not building C++.
1. `--crosstool_top`, which specifies exactly what command line should compile
   your code, is even more tied to C++. Other languages may be organized
   completely differently.
1. `--define` is completely unstructured and unreadable in Starlark.
1. `$ bazel build //my:all` sets the same flags for all targets, even if
   different targets need different flags.
1. `//my:binary`'s deps must use the same settings as their parent.
1. It might be hard to remember which flags are needed by which targets,
   especially across users and dev/test/prod machines. This makes it hard to
   be confident in the integrity of your builds.

Another approach might be to set flags directly in targets that need them, let
rule writers design the flags that affect their rules, and provide standard APIs
for cross-language concepts like *platform* and *cpu*. This lets developers
configure projects on their own terms, using language consistent with how their
projects are organized. This is the essence of the work we're doing.

## Configuration vs. Attributes

Rules have always had [attributes](https://docs.bazel.build/versions/master/skylark/rules.html#attributes),
which also affect how they build. So why do we even need configuration?

The difference between configuration and attributes is attributes only affect
the rule's
[direct build actions](https://docs.bazel.build/versions/master/skylark/rules.html#implementation-function).
This means attributes **cannot affect how a rule's dependencies build**.

For example, C++ rules have an attribute named
[`copts`](https://docs.bazel.build/versions/master/be/c-cpp.html#cc_binary.copts)
that sets custom C++ compile options. `cc_binary(name = "mybinary", srcs =
["mybinary.cc"], deps = [":mylibrary"], copts =
["-DUSE_EXPERIMENTAL_FEATURES=1"])` might compile `mybinary.cc` with
experimental features. But this won't happen for `":mylibrary"` unless it sets
its `copts` similarly. This makes attributes unsuitable for tasks like building
a binary for a different CPU.

If you imagine a build as a [graph](https://docs.bazel.build/versions/master/build-ref.html#dependencies)
with parents above their dependencies, attributes change behavior
[*up*](https://docs.bazel.build/versions/master/skylark/rules.html#providers)
the graph while configuration changes behavior *down* the graph.

## Platforms

One of our team's major goals is designing a principled API for defining
*platforms* and *toolchains*.

While there are many kinds of "ways" you might want to build your project, in
practice most developers want the flexibility to target different devices,
OSes, CPUs, and other machine properties. The general term for this is
*platforms*. Being able to reason about how your code interacts with platforms
is the basis of [multi-platform software](https://en.wikipedia.org/wiki/Cross-platform_software).

*Toolchains* are the set of programs that build your code. A C++ toolchain
includes a compiler and linker and the flags that invoke them "correctly".
Different platforms require different toolchains. gcc might be the compiler of
choice for Linux while Xcode is used on the Mac. Even the same platform might
use different toolchains. For example, maybe you want to use an experimental
compiler.

Not only are these concepts cross-language, but it's *important* that languages
treat them consistently. Otherwise you get an uncoordinated mess of
language-specific code that makes it hard to combine different languages in a
single project.

One of the reasons

    $ bazel build //my:binary --cpu=arm --crosstool_top=//my:custom_toolchain --define MYFEATURE=1

doesn't work well is that `--cpu` and `--crosstool_top` are C++-specific. What
if you want to build Java libraries with C++ dependencies for both Linux and
Android? This impacts not just C++, but also the JDK and maybe even which
support libraries you need.

Not only are `--cpu` and `-crosstool_top` insufficiently expressive, but they
might actively sabotoge you. Consider the following use of
[select](https://docs.bazel.build/versions/master/configurable-attributes.html):

```python
config_setting(name = "android", values = {"cpu": "arm", "crosstool_top": "//my:android_toolchain"})
java_library(
    name = "supporting_library",
    deps = select({
        ":android": [":extra_required_android_deps"],
        "//conditions:default": []
    }))
```

If you use `--cpu` and `crosstool_top` to define what `":android"` means, what
happens when an app supports a new Android phone with a different CPU?
`":android"` won't trigger because `--cpu` no longer matches, the app won't get
required Android support libraries, and it will break.

### A Better Way

The configurability's team's platform work, led by [@katre](https://github.com/katre),
lets you declare exactly what you want in a way all rules understand. It
doesn't even matter if no one's ever heard of your platform.

With the new API, our example can be rewritten as:

```python
$ cat platforms/BUILD
constraint_setting(name = "os")
constraint_value(name = "android", constraint_setting = ":os")
constraint_value(name = "linux", constraint_setting = ":os")

constraint_setting(name = "device")
constraint_value(name = "phone", constraint_setting = ":device")
constraint_value(name = "tablet", constraint_setting = ":device")

platform(name = "pixel3", constraint_values = [":android", ":phone"])
```

```python
$ cat helpers/BUILD
config_setting(name = "android", constraint_values = ["//platforms:android"])
java_library(
    name = "supporting_library",
    deps = select({
        ":android": [":extra_required_android_deps"],
        "//conditions:default": []
    }))
```

and built with:

    $ bazel build //my:binary --platforms=//platforms:pixel3 --define MYFEATURE=1

This is a significant improvement over before. It's more concise and you no
longer have to care what the CPU is. *Any* platform with the `constraint_value`
`":android"` is an Android platform. So it's easy to express *exactly* what you
want and have `select`, rules, and toolchains understand it the same way.
`MYFEATURE=1`, which isn't a platform property, remains as before.

Rules understand `":android"` by declaring [toolchain types](https://docs.bazel.build/versions/master/toolchains.html#writing-rules-that-use-toolchains).
For example, `java_binary` can be defined in Starlark as

```python
java_binary = rule(..., toolchains = ["@bazel_tools//tools/jdk:toolchain_type"])
```

This tells Bazel that `java_binary` understands toolchains that set
`["@bazel_tools//tools/jdk:toolchain_type"]`. You can then write a Java
toolchain for Android as:

```python
toolchain(
    name = "android_jdk",
    toolchain_type = ["@bazel_tools//tools/jdk:toolchain_type"],
    target_compatible_with = ["//platforms:android"],
    toolchain = ":android_jdk_provider_rule")
```

where `android_jdk_provider_rule` is a Starlark rule that
[provides](https://docs.bazel.build/versions/master/skylark/rules.html#providers)
 access to the actual JDK tools.

This takes some infrastructure to set up, but the result is magic. Call your
build with `--platforms=//platforms:pixel3` and `java_binary` automatically
uses `":android_jdk"`. All rules can join in on this. The only obligations rule
designers have are to write [Starlark rules](https://docs.bazel.build/versions/master/toolchains.html#defining-toolchains)
describing how their toolchains work and define toolchains for the platforms
they support.

This brings us closer to the goal of `$ bazel build //:all` *just working* by
replacing ad hoc language-specific flags with a single flag that works everywhere.

### Status

You can use platforms today. The catch is that rules have to opt in support by
including definitions of how their toolchains work. If you're designing a new
set of rules, you should [design](https://docs.bazel.build/versions/master/toolchains.html)
them for platforms. But most existing rules predate this work and still rely on
legacy flags like
[`--javabase`](https://source.bazel.build/bazel/+/0b84634f3be1118bdbd501f3d879382d6ae52307:src/main/java/com/google/devtools/build/lib/rules/java/JavaOptions.java;l=75).

As of this post, Bazel's platform work is heavily focused on rules migration. 
C++ rules are [near ready](https://github.com/bazelbuild/bazel/issues/6516) and
due to be [officially integrated](https://github.com/bazelbuild/bazel/issues/7260)
mid-2019. [Java](https://github.com/bazelbuild/bazel/issues/6521) and
[Python](https://github.com/bazelbuild/bazel/issues/7375) rules will follow soon
after (follow the relevant tracking bugs for best estimates). These will be
important milestones in demonstrating this work's value and providing best
practice examples for others.

`--cpu`, `--crosstool_top` and other legacy flags will eventually be removed
from Bazel. Since rules are migrating on different timelines and projects
still use these flags for
[`select`](https://docs.bazel.build/versions/master/configurable-attributes.html
) and command lines, an [interoperability
phase](https://github.com/bazelbuild/bazel/issues/6426) will keep them working as long as you need.

For more details, see Bazel's [platforms roadmap](https://bazel.build/roadmaps/platforms.html),
[configurability roadmap](https://bazel.build/roadmaps/configuration.html),
[platform](https://docs.bazel.build/versions/master/platforms.html)
and [toolchain](https://docs.bazel.build/versions/master/toolchains.html)
docs, and the original [design doc](https://docs.google.com/document/d/1-G-VPRLEj9VyfC6VrQBiR8To-dZjnBSQS66Y4nargGM/edit?ts=57df9619#heading=h.al54v2ddwqzv).
Or contact the team at [bazel-discuss@googlegroups.com](https://groups.google.com/forum/#!forum/bazel-discuss).

Special thanks to [@katre](https://github.com/katre) for leading Bazel's
platform vision and [@hlopko](https://github.com/hlopko) and
[@lberki](https://github.com/lberki) for important C++ contributions.

## Part 2...

Stay tuned for *Configurable Builds - Part 2*, coming out soon. We'll talk about
building different targets with different settings through *transitions*. We'll
also discuss why you need to watch your build size when using these features.

