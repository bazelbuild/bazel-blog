---
layout: posts
title: "Writing fuzz tests with ease using Bazel"
authors:
  - stefanbucur
  - asraa
  - abhishekarya
---

**We are announcing Bazel support for developing and testing fuzz tests, with OSS-Fuzz integration, through the new [`rules_fuzzing` Bazel library](https://github.com/bazelbuild/rules_fuzzing).**

[Fuzzing](https://github.com/google/fuzzing/blob/master/docs/intro-to-fuzzing.md) is an effective, well-known testing technique for finding security and stability bugs in software. But writing and testing fuzz tests can be [tedious](https://github.com/google/oss-fuzz/blob/e81d27e287007d9bb490349ed492ce430e31badc/projects/envoy/build.sh). Developers typically need to:

* Implement a [fuzz driver function](https://github.com/bazelbuild/rules_fuzzing/blob/9b06352aea3a948567be5bd2a8c2c142d9bd85ad/examples/re2_fuzz_test.cc), which exercises the API under test;
* Build the code with the proper instrumentation (such as [Address Sanitizer](https://clang.llvm.org/docs/AddressSanitizer.html));
* Link it with one of the available fuzzing engine libraries (libFuzzer, AFL++, Honggfuzz, etc.) that provide the core test generation logic;
* Run the fuzz test binary with the right set of flags (e.g., to specify [corpora](https://github.com/google/fuzzing/blob/master/docs/good-fuzz-target.md#seed-corpus) or [dictionaries](https://github.com/google/fuzzing/blob/master/docs/good-fuzz-target.md#dictionaries));
* Package the fuzz test and its resources for consumption by fuzzing infrastructures, such as [OSS-Fuzz](https://github.com/google/oss-fuzz).

Unfortunately, build systems don't traditionally offer any support beyond the core primitives of producing executables, so projects adopting fuzzing often end up reimplementing fuzz test recipes.

[Bazel](https://bazel.build/) is a versatile and extensible build system, focused on scalable, reliable, and reproducible builds. Originally designed to scale to Google's entire monolithic repository, it now underpins [large enterprises and key open source Internet infrastructure projects](https://bazel.build/users.html).

We are pleased to announce that projects using Bazel can get advanced fuzzing support through the new [`rules_fuzzing` extension library](https://github.com/bazelbuild/rules_fuzzing). The new fuzzing rules take care of all the boilerplate needed to build and run fuzz tests. Developers simply write the fuzz driver code and define a build target for it (example [driver](https://github.com/bazelbuild/rules_fuzzing/blob/6d70dfa5ae3908404a4c8c2c5c52e86ab9f4b77c/examples/re2_fuzz_test.cc) and [target](https://github.com/bazelbuild/rules_fuzzing/blob/6d70dfa5ae3908404a4c8c2c5c52e86ab9f4b77c/examples/BUILD#L104-L110) for RE2). Fuzz tests can be built and run using a number of fuzzing engines provided out-of-the-box, such as [libFuzzer](https://llvm.org/docs/LibFuzzer.html) and [Honggfuzz](https://github.com/google/honggfuzz), as well as sanitizers. The rule library also provides the ability to define additional fuzzing engines.

You can integrate the fuzzing library with [around 10 LOC](https://github.com/bazelbuild/rules_fuzzing#configuring-the-workspace) in your Bazel WORKSPACE file. Defining a fuzz test in Bazel is as easy as writing the following in your BUILD file:

```python
load("@rules_fuzzing//fuzzing:cc_deps.bzl", "cc_fuzz_test")
cc_fuzz_test(
    name = "my_fuzz_test",
    srcs = ["my_fuzz_test.cc"],
    deps = [":my_library"],
)
```

You can easily test the fuzzer locally by invoking its launcher:

```sh
$ bazel run --config=asan-libfuzzer //:my_fuzz_test_run
```

To improve the effectiveness of test case generation, fuzz tests also support seed corpora and dictionaries, through additional rule attributes. They will automatically be validated and included in fuzz test runs. Fuzz tests also serve as regression tests on the seed corpus. For example, you can add previously found and fixed crashes to the corpus and have them tested in your CI workflows:

```sh
$ bazel test --config=asan-replay //:my_fuzz_test
```

The fuzzing rules provide built-in support for [OSS-Fuzz](https://github.com/google/oss-fuzz), our continuous fuzzing service for open source projects. The [OSS-Fuzz support](https://google.github.io/oss-fuzz/getting-started/new-project-guide/bazel/) drastically [simplifies writing the build scripts](https://github.com/google/oss-fuzz/blob/20b7246eae02785153ada2ae3dad97a546c7f589/projects/bazel-rules-fuzzing-test/build.sh) in project integration by automatically packaging the fuzz test and its dependencies using the expected OSS-Fuzz structure.

The [Envoy Proxy project](https://www.envoyproxy.io/) is one of the early adopters of the fuzzing rules library. As a large, mature C++ codebase, Envoy has maintained its own custom implementation of fuzzing support for its over 50 fuzz targets written so far. By switching to the new Bazel fuzzing rules, Envoy's fuzz targets automatically gained new features, such as local running and testing tools and support for multiple fuzzing engines. At the same time, Envoy simplified its [OSS-Fuzz integration scripts](https://github.com/google/oss-fuzz/pull/5062/files). Moreover, it will automatically gain future functionality (e.g., more effective fuzzing engines, better coverage tracking, improved corpus management) as the Bazel fuzzing rules library evolves.

The [Bazel rules for fuzzing](https://github.com/bazelbuild/rules_fuzzing) draw from Google's experience providing effective fuzzing tools to our internal developers. We hope the new Bazel support for fuzzing will lower the barrier to fuzzing adoption in open source communities, further increasing the security and reliability of many projects. To learn more about integrating the fuzzing rules into your project, take a look at the [Getting Started section](https://github.com/bazelbuild/rules_fuzzing#getting-started) in the documentation.

By Stefan Bucur, Software Analysis, Asra Ali, Envoy, and Abhishek Arya, OSS-Fuzz – Google
