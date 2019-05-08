---
layout: posts
title: "Bazel on Windows without MSYS2"
authors:
  - laszlocsomor
---

**With Bazel 0.26.0, <code>bazel&nbsp;test</code> will work without Bash (MSYS2) on Windows.**

Bazel 0.26.0 brings big changes on Windows. With the new
`--incompatible_windows_native_test_wrapper` flag, you can build and test Java, C++, and Python code
on Windows without having to install Bash (MSYS2 shell). We plan to enable this flag by default in
Bazel 0.27.0 (ETA June 2019).

(In fact Bazel 0.25.0 already supports this flag, we just kept silent about it due to
[issue #8005](https://github.com/bazelbuild/bazel/issues/8005), which is fixed in Bazel 0.26.0.)

Give it a try!

1.  Download [Bazel 0.26.0](https://releases.bazel.build/0.26.0/release/index.html).

    Save it as `C:\bazel-releases\0.26.0\bazel.exe` for example.

1.  `git clone https://github.com/bazelbuild/examples.git C:/src/bazel-examples`

1.  In cmd.exe:

    ```
    set BAZEL_SH=

    cd /D c:\src\bazel-examples\java-maven

    C:\bazel-releases\0.26.0\bazel.exe test --shell_executable= --incompatible_windows_native_test_wrapper //...
    ```

Let us know [if you like it](mailto:bazel-discuss+windows@googlegroups.com) or
[if you find any problems](https://github.com/bazelbuild/bazel/issues/new)!

While we are elated to tell you these news, we must stay grounded: **not all ties are cut yet**. You
still need Bash when:

-   using <code>bazel&nbsp;run</code> (see
    [issue #8229](https://github.com/bazelbuild/bazel/issues/8229))
-   building certain repository rules (e.g. `git_repostory`)
-   building `genrule`, `sh_*` rules, and Starlark rules with shell actions
    (`ctx.actions.run_shell()`).

We are working on the first two. For the third, you might find a suitable replacement in the
[Bazel Skylib repository](https://github.com/bazelbuild/bazel-skylib/tree/master/rules) that doesn't
require Bash on Windows, and there's also
[issue #7503](https://github.com/bazelbuild/bazel/issues/7503).
