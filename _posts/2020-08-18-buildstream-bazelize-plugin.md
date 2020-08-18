---
layout: posts
title: Consuming BuildStream projects in Bazel: the bazelize plugin
authors:
  - traveltissues
---

The following is adapted from a post originally published at the [Codethink Blog](https://www.codethink.co.uk/articles/2020/consuming-buildstream-projects-in-bazel-the-bazelize-plugin/).

## Bazel and BuildStream

A particular difficulty for [Bazel](https://docs.bazel.build/versions/3.1.0/bazel-overview.html) project owners is integrating their application with foreign libraries. Pre-compiled libraries impart the burden of maintaining available archives which are difficult to effectively inspect in change control processes. These libraries must also be visible as valid targets in the Bazel project which requires manually defining those targets: files are often collected as target sources via greedy regexes which obscures the explicit list of filenames. Finally, when the application is shipped it requires a clean environment that integrates those libraries. This is often accomplished using a Docker container with the drawback that the application is then closely coupled to this format. If those libraries need to be built from source then [bespoke  rules](https://github.com/bazelbuild/rules_foreign_cc) are required to dispatch foreign build systems (such as CMake) in addition to the above mentioned integrations.

[BuildStream](https://gitlab.com/BuildStream/buildstream) neatly handles the above category of problem by operating at a higher level of abstraction than Bazel. The Buildstream client's perspective of builds is from a system level with inputs consisting of discrete elements. Configuration allows for local availability of elements in remote projects as well as multiple output formats via a plugin system. Buildstream shares [compatible goals](https://youtu.be/21VPe7HcuPE) with the Bazel client; they both aim to produce deterministic build products in an efficient and fast manner by employing caching and analysis to avoid unnecessary computation. As a side benefit, these caching strategies facilitate the sharing of build products.

BuildStream could be adopted by Bazel users to achieve greater flexibility and an easier path to integrating third party dependencies specifically because it gracefully handles remote sources, remote projects, integrations, and multiple formats and build systems. However, there is no clear path to integrating the product of a BuildStream project (an artifact) as a dependency in a Bazel project. For example, building `libfoo.so` in a BuildStream project will not render the library available as a target in a Bazel project because there is no valid Bazel target binding that library. Consequently the artifact needs to be packaged as a Bazel project. This has generally been [accomplished manually](https://gitlab.com/celduin/buildstream-bazel/bazel-gtk-hello/-/blob/master/main/BUILD) and is non-trivial for projects as complex as a typical Linux environment which imparts significant cost to the developer.

## The bazelize plugin

### Overview

The [bazelize  plugin](https://gitlab.com/BuildStream/bst-plugins-experimental/-/blob/master/src/bst_plugins_experimental/elements/bazelize.py) eases the consumption of artifacts by Bazel projects. Technically it allows the artifact to be recognized as a Bazel package by providing a BUILD file. Currently this automation is limited to a subset of Bazel rules for constructing [C/C++ targets](https://docs.bazel.build/versions/3.1.0/be/c-cpp.html#cc_library): the plugin offers `cc_import` and `cc_library` targets automatically with the ability to override these rules (for example with `cc_binary`).

Targets are gathered for inclusion in the package by traversing the dependency graph of the element. The manifest (which dynamically provides mapping of elements to artifact files) is inspected for files with extensions matching those which would be valid values in the `srcs` field of `cc_library`. The dependencies of these targets themselves are also inspected in order to populate the `deps` field of the relevant Bazel rules.

Gathered targets are transformed several times to ensure correctness: unresolved dependencies are removed and field values are sorted so that the contents of the package will be deterministic. Additionally, `cc_library` targets that meet a certain criteria are transformed into `cc_import` targets. This collection of targets is formatted and written directly to a file defining the package.

### Configuration

Like other BuildStream plugins, the bazelize plugin is configurable at an element level: several keys are supported to allow the creation of subpackages in the artifact and to override default Bazel rules as well as specifying linking and compiling options. Additionally a special 'none' rule is provided to prevent the element itself from appearing in the package. This is particularly useful when it's used as a bolt-on to the top of a BuildStream project: it can be used to provide Bazel target bindings for its dependencies and act as a transparent translation layer between the projects.

```yaml
config:
  # output directory for the buildfile
  buildfile-dir: "%{prefix}"
  # list of options to add to the C++ compilation command
  copts: []
  # list of defines to add to the compile line
  linkopts: []
  bazel-rule: "BST.BAZEL_NONE_RULE"
```

### Depending on a BuildStream artifact

As a contrived example consider the [shift-cipher](https://gitlab.com/traveltissues/shift-cipher/-/tree/bazelize-example) project (a toy project for mapping latin characters to latin characters). This Bazel package provides a binding for `cipher-shifter` that depends upon the static library `libshift_cipher_lib.a`. In a traditional Bazel project the `cipher-shifter` target might be defined as:

```
cc_binary(
	name = "cipher-shifter",
	srcs = ["cipher-shifter-srcs",],
	deps = ["libshift-cipher-lib",],
)
```

However, the library is part of the artifact (specifically it's imported by the `libshift.bst` element) and so is invisible to Bazel. The `libimport.bst` element depends upon `libshift.bst` and when built produces a BUILD file as an artifact:

```
package(default_visibility = ["//visibility:public"])
load("@rules_cc//cc:defs.bzl", "cc_import")
cc_import(
	name = "libshift",
	static_library = "libshift_cipher_lib.a",
)
```

Executing `bst build libimport.bst && bst artifact checkout libimport.bst` will make the artifact available at `./libimport` as a Bazel subpackage. The dependency is now available to the Bazel project:

```
cc_binary(
	name = "cipher-shifter",
	srcs = ["cipher-shifter-srcs",],
	deps = ["//libimport:libshift",],
)
```

## Summary

Development of the bazelize plugin has now reached a point where simple libraries can be constructed and consumed as dependencies in Bazel projects. However it is still experimental and has some considerable limitations: it only supports a small number of rules, visibility is not configurable at the target level, `copts` and `linkopts` need to be explicitly configured, files are included via path globbing rather than inspection, and subpackages are only naively supported.

Integrating BuildStream projects which provide global dependencies and toolchains to Bazel projects can significantly reduce development and maintenance cost to the application owners. As discussed above this reduces the burden of archive availability, allows for easier change control, and handles remote dependencies gracefully. Installer [scripts](https://github.com/ApolloAuto/apollo/tree/master/docker/build/installers) in the Apollo program, for example, can be replaced with a single BuildStream project which is not itself necessarily colocated with the Bazel project. The only requirement is that the artifact is accessible (which can be achieved via a federal cache) and the bazelize plugin will provide the necessary target bindings automatically. This neatly resolves the issue of non-application dependencies discussed above and allows Bazel project owners to leverage BuildStream’s integration abilities.

## How to get involved

The source code is openly available at [https://gitlab.com/BuildStream/bst-plugins-experimental](https://gitlab.com/BuildStream/bst-plugins-experimental) and contributions are welcome, both issues and merge requests. Some future issues for the plugin are already planned out at [https://gitlab.com/groups/celduin/buildstream-bazel/-/milestones/10](https://gitlab.com/groups/celduin/buildstream-bazel/-/milestones/10). You can reach me on `irc.gimp.net` and `chat.freenode.net` as `traveltissues` or email me at darius.makovsky@codethink.co.uk.
