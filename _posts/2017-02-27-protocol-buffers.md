---
layout: posts
title: Protocol Buffers in Bazel
authors:
  - cgrushko
---

Bazel currently provides rules for Java, JavaLite and C++.

<!-- TODO(yannic): Create documentation for rules_proto and link to that instead. 
     https://github.com/bazelbuild/bazel/issues/9203 -->
[`proto_library`]({{ site.docs_site_url }}/be/protocol-buffer.html#proto_library)
is a language-agnostic rule that describes relations between `.proto` files.

[`java_proto_library`]({{ site.docs_site_url }}/be/java.html#java_proto_library),
[`java_lite_proto_library`]({{ site.docs_site_url }}/be/java.html#java_lite_proto_library)
and
[`cc_proto_library`]({{ site.docs_site_url }}/be/c-cpp.html#cc_proto_library)
are rules that "attach" to `proto_library` and generate language-specific
bindings.

By making a `java_library` (resp. `cc_library`) depend on `java_proto_library`
(resp. `cc_proto_library`) your code gains access to the generated code.

## TL;DR - Usage example

> TIP:
> [https://github.com/cgrushko/proto_library](https://github.com/cgrushko/proto_library)
> contains a buildable example.

### WORKSPACE file

Bazel's proto rules implicitly depend on the
[https://github.com/google/protobuf](https://github.com/google/protobuf)
distribution (described below, in "Implicit Dependencies and Proto Toolchains").
The following satisfies these dependencies:

> TIP: Clone [https://github.com/cgrushko/proto_library](https://github.com/cgrushko/proto_library) to try protobufs in Bazel now.

> **Update (February 2020)**: Starting with Bazel 3.0, the minimum Protocol Buffer
version required is [**3.11.3**] (https://github.com/protocolbuffers/protobuf/releases/tag/v3.11.3).
See this [issue](https://github.com/bazelbuild/bazel/issues/10335) for more information.

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_cc defines rules for generating C++ code from Protocol Buffers.
http_archive(
    name = "rules_cc",
    sha256 = "35f2fb4ea0b3e61ad64a369de284e4fbbdcdba71836a5555abb5e194cf119509",
    strip_prefix = "rules_cc-624b5d59dfb45672d4239422fa1e3de1822ee110",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_cc/archive/624b5d59dfb45672d4239422fa1e3de1822ee110.tar.gz",
        "https://github.com/bazelbuild/rules_cc/archive/624b5d59dfb45672d4239422fa1e3de1822ee110.tar.gz",
    ],
)

# rules_java defines rules for generating Java code from Protocol Buffers.
http_archive(
    name = "rules_java",
    sha256 = "ccf00372878d141f7d5568cedc4c42ad4811ba367ea3e26bc7c43445bbc52895",
    strip_prefix = "rules_java-d7bf804c8731edd232cb061cb2a9fe003a85d8ee",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_java/archive/d7bf804c8731edd232cb061cb2a9fe003a85d8ee.tar.gz",
        "https://github.com/bazelbuild/rules_java/archive/d7bf804c8731edd232cb061cb2a9fe003a85d8ee.tar.gz",
    ],
)

# rules_proto defines abstract rules for building Protocol Buffers.
http_archive(
    name = "rules_proto",
    sha256 = "2490dca4f249b8a9a3ab07bd1ba6eca085aaf8e45a734af92aad0c42d9dc7aaf",
    strip_prefix = "rules_proto-218ffa7dfa5408492dc86c01ee637614f8695c45",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/218ffa7dfa5408492dc86c01ee637614f8695c45.tar.gz",
        "https://github.com/bazelbuild/rules_proto/archive/218ffa7dfa5408492dc86c01ee637614f8695c45.tar.gz",
    ],
)

load("@rules_cc//cc:repositories.bzl", "rules_cc_dependencies")
rules_cc_dependencies()

load("@rules_java//java:repositories.bzl", "rules_java_dependencies", "rules_java_toolchains")
rules_java_dependencies()
rules_java_toolchains()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()
```

### BUILD files

> TIP: Clone [https://github.com/cgrushko/proto_library](https://github.com/cgrushko/proto_library) to try protobufs in Bazel now.

```python
load("@rules_cc//cc:defs.bzl", "cc_proto_library")
load("@rules_java//java:defs.bzl", "java_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")

java_proto_library(
    name = "person_java_proto",
    deps = [":person_proto"],
)

cc_proto_library(
    name = "person_cc_proto",
    deps = [":person_proto"],
)
proto_library(
    name = "person_proto",
    srcs = ["person.proto"],
    deps = [":address_proto"],
)

proto_library(
    name = "address_proto",
    srcs = ["address.proto"],
    deps = [":zip_code_proto"],
)

proto_library(
    name = "zip_code_proto",
    srcs = ["zip_code.proto"],
)
```

This file yields the following dependency graph:

![proto_library dependency graph](/assets/proto_library-dep-graph.png)

Notice how the `proto_library` provide structure for both Java and C++ code
generators, and how there's only one `java_proto_library` even though there
multiple `.proto` files.

## Benefits

... in comparison with a macro that's responsible for compiling all `.proto`
files in a project.

1.  Caching + incrementality: changing a single `.proto` only causes the
    rebuilding of dependant `.proto` files. This includes not only regenerating
    code, but also recompiling it. For large proto graphs this could be
    significant.
2.  Depend on pieces of a proto graph from multiple places: in the example
    above, one can add a `cc_proto_library` that `deps` on `zip_code_proto`, and
    including it together with `//src:person_cc_proto` in the same project.
    Though they both transitively depend on `zip_code_proto`, there won't be a
    linking error.

## Recommended Code Organization

1.  One proto_library rule per `.proto` file.
2.  A file named `foo.proto` will be in a rule named `foo_proto`, which is
    located in the same package.
3.  A `<lang>_proto_library` that wraps a `proto_library` named `foo_proto` should be
    called `foo_<lang>_proto`, and be located in the same package.

## FAQ

**Q:** I already have rules or macros named `proto_library`, `java_proto_library`,
and `cc_proto_library`. Will there be a problem?<br />
**A:** No. Since these rules are explicitely loaded through `load` statements,
the new rule should not affect existing usage of the rules or macros.

<!-- TODO(yannic): This is outdated. -->
**Q:** How do I use gRPC with these rules?<br />
**A:** The Bazel rules do not generate RPC code since `protobuf` is independent
of any RPC system. We will work with the gRPC team to create Skylark extensions
to do so. ([C++ Issue](https://github.com/grpc/grpc/issues/9873), [Java
Issue](https://github.com/grpc/grpc-java/issues/2756))

**Q:** Do you plan to release additional languages?<br />
**A:** We're currently [rewriting the existing](https://docs.google.com/document/d/1u95vlQ1lWeQNR4bUw5T4cMeHTGJla2_e1dHHx7v4Dvg/edit)
rules for C++ and Java in Starlark, making them independent of Bazel.
We may add rules for other languages after this work is finished.

**Q:** How does one use well-known types? (e.g., `any.proto`,
`descriptor.proto`)<br />
**A:** See [the example repo](https://github.com/cgrushko/proto_library), particularly https://github.com/cgrushko/proto_library/blob/beae7b78b85b3af51d3ea54663c421ebde97dc10/src/BUILD#L42.

<!-- TODO(yannic): This is outdated. -->
<!-- TODO(yannic): rules_proto will contain a framework for writing rules and a guide
                   how to do so. Link to that instead. -->
**Q:** Any tips for writing my own such rules?<br />
**A:** First, make sure you're able to register actions that compile your target
language. (as far as I know, Bazel Python actions are not exposed to Skylark,
for example).<br />
Second, take extra care to generate unique symbol names and unique filenames.
There's an implicit assumption that different proto rules with different
options, generate different symbols. For example, if you write a new rule
`foo_java_proto_library`, it must not generate symbols that `java_proto_library`
might. The risk is that a binary will contain both, leading to a one-definition
rule violation (e.g., linking errors). The downside is that the binary might
bloat, as it must contain multiple generated code for the same proto. We're
working on a Skylark version of `java_lite_proto_library` which should provide a
good example.

## Implementation Details

### Implicit Dependencies and Proto Toolchains

<!-- TODO(yannic): This will need to be updated when the flags are removed. -->
The `proto_library` rule implicitly depends on `@com_google_protobuf//:protoc`,
which is the protocol buffer compiler. It must be a binary rule (in protobuf,
it's a `cc_binary`). The rule can be overridden using the `--proto_compiler`
command-line flag.

Most `<lang>_proto_library` rules implicitly depend on
`@com_google_protobuf//:<lang>_toolchain`, which is a `proto_lang_toolchain` rule.
These rules can be overridden using the `--proto_toolchain_for_<lang>` command-line
flags.

A `proto_lang_toolchain` rule describes how to call the protocol compiler, and
what is the library (if any) that the resulting generated code needs to compile
against. See an [example in the protobuf
repository](https://github.com/google/protobuf/blob/b4b0e304be5a68de3d0ee1af9b286f958750f5e4/BUILD#L773).

### Bazel Aspects

The `<lang>_proto_library` rules are implemented using [Bazel
Aspects]({{ site.docs_site_url }}/skylark/aspects.html) to have
the best of two worlds -

1.  Only need a single `<lang>_proto_library` rule for an arbitrarily-large proto
    graph.
2.  Incrementality, caching and no linking errors.

Conceptually, an `<lang>_proto_library` rule creates a shadow graph of the
`proto_library` it depends on, and each shadow node calls protocol-compiler and
then compiles the generated code. This way, if there are multiple paths from a
rule to a `proto_library` through `<lang>_proto_library`, they all share the same
node.

### Descriptor Sets

When compiled on the command-line, a `proto_library` creates a descriptor set
for the messages it `srcs`. The file is a serialized `FileDescriptorSet`, which
is described in
[https://developers.google.com/protocol-buffers/docs/techniques#self-description](https://developers.google.com/protocol-buffers/docs/techniques#self-description).

One use case for the descriptor set is generating code without having to parse
`.proto` files.
([https://github.com/google/protobuf/issues/2725](https://github.com/google/protobuf/issues/2725)
tracks this ability in the protobuf compiler)

The aforementioned file only contains information about the `.proto` files
directly mentioned by a `proto_library` rule; the collection of transitive
descriptor sets is available through the `proto.transitive_descriptor_sets`
Skylark provider. See [documentation in
ProtoSourcesProvider](https://github.com/bazelbuild/bazel/blob/5dbb23ba44ec0037cf0944b17716ea3f08a69c27/src/main/java/com/google/devtools/build/lib/rules/proto/ProtoSourcesProvider.java#L121).
