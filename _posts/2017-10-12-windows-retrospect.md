---
layout: posts
title: Bazel on Windows: a year in retrospect
---

Bazel on Windows is no longer experimental. We think Bazel on Windows is now
stable and usable enough to qualify for the Beta status we have given Bazel on
other platforms.

Over the last year, we put a lot of work into improving Bazel's Windows support:

*   **Bazel no longer depends on the MSYS runtime.** This means Bazel is now a
    native Windows binary and we no longer link it to the MSYS DLLs. Bazel still
    needs Bash (MSYS or Git Bash) and the GNU binutils (binaries under
    `/usr/bin`) if your dependency graph includes `genrule` or `sh_*` rules
    (similarly to requiring `python.exe` to build `py_*` rules), but you can use
    any MSYS version and flavour you like, including Git Bash.
*   **Bazel can now build Android applications.** If you use native `android_*`
    rules, Bazel on Windows can now build and deploy Android applications.
*   **Bazel is easier to set up.** You now (typically) no longer need to set the
    following environment variables:
    *   `BAZEL_SH` and `BAZEL_PYTHON` -- Bazel attempts to autodetect your Bash
        and Python installation paths.
    *   `JAVA_HOME` -- we release Bazel with an embedded JDK. (We also release
        binaries without an embedded JDK if you want to use a different one.)
*   **Visual C++ is the default C++ compiler.** We no longer use GCC by default,
    though Bazel still supports it.
*   **Bazel integrates better with the Visual C++ compiler.** Bazel no longer
    dispatches to a helper script to run the compiler; instead Bazel now
    has a `CROSSTOOL` definition for Visual C++ and drives the compiler
    directly. This means Bazel creates fewer processes to run the compiler. By
    removing the script, we have eliminated one more point of failure.
*   **Bazel creates native launchers.** Bazel builds native Windows executables
    from `java_binary`, `sh_binary`, and `py_binary` rules. Unlike the .`cmd`
    files that Bazel used to build for these rules, the new .`exe` files no
    longer dispatch to a shell script to launch the `xx_binaries`, resulting in
    faster launch times. (If you see errors, you can use the
    `--[no]windows_exe_launcher` flag to fall back to the old behavior; if you
    do, please [file a bug](https://github.com/bazelbuild/bazel/issues/new).
    We'll remove this flag.)

## Coming soon

We are also working on bringing the following to Bazel on Windows:

*   **Android Studio integration.** We'll ensure Bazel works with Android Studio
    on Windows the same way it does on Linux and macOS. See
    [issue #3888](https://github.com/bazelbuild/bazel/issues/3888).
*   **Dynamic C++ Linking.** Bazel will support building and linking to DLLs on
    Windows. See [issue #3311](https://github.com/bazelbuild/bazel/issues/3311).
*   **Skylark rule migration guide.** We'll publish tutorials on writing Skylark
    rules that work not just on Linux and macOS, but also on Windows. See
    [issue #3889](https://github.com/bazelbuild/bazel/issues/3889).

*By [László Csomor](https://github.com/laszlocsomor)*
