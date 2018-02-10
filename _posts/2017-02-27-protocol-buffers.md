---
layout: posts
title: Protocol Buffers in Bazel
---

Bazel currently provides built-in rules for Java, JavaLite and C++.

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
>
> NOTE: Bazel 0.4.4 lacks some features the example uses - you'll need to build
> Bazel from head. The easiest is to install Bazel, download Bazel's source
> code, build it (`bazel build //src:bazel`) and copy it somewhere (e.g., `cp
> bazel-bin/src/bazel ~/bazel`)

### WORKSPACE file

Bazel's proto rules implicitly depend on the
[https://github.com/google/protobuf](https://github.com/google/protobuf)
distribution (described below, in "Implicit Dependencies and Proto Toolchains").
The following satisfies these dependencies:

> TIP: Clone https://github.com/cgrushko/proto_library/ to try protobufs in Bazel now.

```python
# proto_library, cc_proto_library, and java_proto_library rules implicitly
# depend on @com_google_protobuf for protoc and proto runtimes.
# This statement defines the @com_google_protobuf repo.
http_archive(
    name = "com_google_protobuf",
    sha256 = "cef7f1b5a7c5fba672bec2a319246e8feba471f04dcebfe362d55930ee7c1c30",
    strip_prefix = "protobuf-3.5.0",
    urls = ["https://github.com/google/protobuf/archive/v3.5.0.zip"],
)

# java_lite_proto_library rules implicitly depend on @com_google_protobuf_javalite//:javalite_toolchain,
# which is the JavaLite proto runtime (base classes and common utilities).
http_archive(
    name = "com_google_protobuf_javalite",
    sha256 = "d8a2fed3708781196f92e1e7e7e713cf66804bd2944894401057214aff4f468e",
    strip_prefix = "protobuf-5e8916e881c573c5d83980197a6f783c132d4276",
    urls = ["https://github.com/google/protobuf/archive/5e8916e881c573c5d83980197a6f783c132d4276.zip"],
)
```

### BUILD files

> TIP: Clone https://github.com/cgrushko/proto_library/ to try protobufs in Bazel now.

```python
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
3.  A `X_proto_library` that wraps a `proto_library` named `foo_proto` should be
    called `foo_X_proto`, and be located in the same package.

## FAQ

**Q:** I already have rules named `java_proto_library` and `cc_proto_library`.
Will there be a problem?<br />
**A:** No. Since Skylark extensions imported through `load` statements take
precedence over native rules with the same name, the new rule should not affect
existing usage of the `java_proto_library` macro.

**Q:** How do I use gRPC with these rules?<br />
**A:** The Bazel rules do not generate RPC code since `protobuf` is independent
of any RPC system. We will work with the gRPC team to create Skylark extensions
to do so. ([C++ Issue](https://github.com/grpc/grpc/issues/9873), [Java
Issue](https://github.com/grpc/grpc-java/issues/2756))

**Q:** Do you plan to release additional languages?<br />
**A:** We can relatively easily create `py_proto_library`. Our end goal is to
improve Skylark to the point where these rules can be written in Skylark, making
them independent of Bazel.

**Q:** How does one use well-known types? (e.g., `any.proto`,
`descriptor.proto`)<br />
**A:** See [the example repo](https://github.com/cgrushko/proto_library), particularly https://github.com/cgrushko/proto_library/blob/beae7b78b85b3af51d3ea54663c421ebde97dc10/src/BUILD#L42.

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

The `proto_library` rule implicitly depends on `@com_google_protobuf//:protoc`,
which is the protocol buffer compiler. It must be a binary rule (in protobuf,
it's a `cc_binary`). The rule can be overridden using the `--proto_compiler`
command-line flag.

Most `X_proto_library` rules implicitly depend on
`@com_google_protobuf//:X_toolchain`, which is a `proto_lang_toolchain` rule.
These rules can be overridden using the `--proto_toolchain_for_X` command-line
flags.

A `proto_lang_toolchain` rule describes how to call the protocol compiler, and
what is the library (if any) that the resulting generated code needs to compile
against. See an [example in the protobuf
repository](https://github.com/google/protobuf/blob/b4b0e304be5a68de3d0ee1af9b286f958750f5e4/BUILD#L773).

### Bazel Aspects

The `X_proto_library` rules are implemented using [Bazel
Aspects]({{ site.docs_site_url }}/skylark/aspects.html) to have
the best of two worlds -

1.  Only need a single `X_proto_library` rule for an arbitrarily-large proto
    graph.
2.  Incrementality, caching and no linking errors.

Conceptually, an `X_proto_library` rule creates a shadow graph of the
`proto_library` it depends on, and each shadow node calls protocol-compiler and
then compiles the generated code. This way, if there are multiple paths from a
rule to a `proto_library` through `X_proto_library`, they all share the same
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

*By [Carmi Grushko](https://github.com/cgrushko)*
