---
layout: posts
title: Android Platforms in Bazel 7.0
authors:
  - katre
---

Many rules in the Bazel ecosystem have migrated to using the
[platforms](https://bazel.build/extending/platforms) and
[toolchains](https://bazel.build/extending/toolchains) systems. We're excited to
announce that, as of Bazel 7.0, the [built-in Android
rules](https://bazel.build/reference/be/android) are joining this group.

## TL;DR: What do I change?

The short version is that instead of using `--fat_apk_cpu`, you'll use `--android_platforms` to indicate what specific device you want your Android APKs to build for.

Just like the `--platforms` flag, the values passed to `--android_platforms` are
the labels of [`platform`](https://bazel.build/reference/be/platforms-and-toolchains#platform) targets, using standard constraint values to describe your device.

For example, for an Android device with a 64-bit ARM processor, you'd define
your platform like this:

```py
platform(
    name = "arm64",
    constraint_values = [
        "@platforms//os:android",
        "@platforms//cpu:arm64",
    ],
)
```

Every Android `platform` should use the [`@platforms//os:android`](https://github.com/bazelbuild/platforms/blob/33a3b209f94856193266871b1545054afb90bb28/os/BUILD#L36) OS constraint. To migrate the CPU constraint, check this chart:

CPU Value     | Platform
------------- | ------------------------------------------
`armeabi-v7a` | `@platforms//cpu:arm`
`arm64-v8a`   | `@platforms//cpu:arm64`
`x86`         | `@platforms//cpu:x86_32`
`x86_64`      | `@platforms//cpu:x86_64`

And, of course, for a multi-architecture APK, you pass multiple labels, for
example: `--android_platforms=//:arm64,//:x86_64` (assuming you defined those in
your top-level `BUILD.bazel` file).

### Are any other flags changing?

Yes, as part of this several legacy flags have been deprecated and are no-ops.

Deprecated flags (and their new equivalents):

- `--android_cpu`: Like `--fat_apk_cpu`, this is replaced by
  `--android_platforms`
- `--android_sdk`: Android SDKs are now registered toolchains, so if you have
  multiple `android_sdk_repository` repository rules defined, you can use
  `register_toolchains` and `--extra_toolchains` to change the order they are
  used in.
- `--android_crosstool_top`: Similarly to the Android SDK, the
  `android_ndk_repository` rule exposes the NDK as a C++ toolchain, using the
  standard toolchain resolution. You can use `register_toolchains` and
  `--extra_toolchains` to change the selection order for these.

### Can I test this out?

Yes, download the latest [Bazel 7.0 release
candidate](https://releases.bazel.build/7.0.0/rc3/index.html) and update your
build flags. Please [file an
issue](https://github.com/bazelbuild/bazel/issues/new/choose) if you encounter
any problems.

### Do I have to migrate?

The legacy functionality is still present in the Bazel 7.0 LTS branch. You can
disable the changes by passing the flag `--noincompatible_enable_android_toolchain_resolution`.

If you find any issues with the new functionality, please [file an
issue](https://github.com/bazelbuild/bazel/issues/new/choose) so that we can
address it.

However, note that the legacy functionality will be deleted in short order and
will not be present in Bazel 8.0 when that is released.

## Why are things changing?

As part of the overall [platforms and
toolchains](https://bazel.build/extending/platforms) project, all of Bazel is
moving away from using `--cpu` flags to express target platforms, and towards
the richer variety allowed by the `platform` rule. The current usage of `--cpu`
is not actually as a single CPU architecture: we currently capture different
things like "Linux on 64-bit intel" (`--cpu=k8`), "macOS on 64-bit-intel"
(`--cpu=darwin_x86_64`), "Windows on ARM" (`--cpu=arm64_windows`): and that's
just a few common OSes.

Once we also want to describe Android and iOS devices, or custom development
boards and their firmware, the single dimension of `--cpu` is insufficient,
which is where the platforms concepts shine.

At a more basic level, because other rules (like C++, Java, Go, and Rust) are
moving to support platforms, Android needs to support it to, so that
mixed-language builds work properly.

## What's next for Android Rules?

The biggest change coming to the Android rules is to move them out of the Bazel
binary, and into [the independent `rules_android`
repository](https://github.com/bazelbuild/rules_android). Starlarkification of
the Android Rules is expected to be complete in Q2 2024, and users will be
encouraged to migrate to the Starlark Android Rules between then and Bazel 8.0

The current version of the Starlark Android rules also supports the same
`--android_platforms` flag, although since these rules aren't currently fully
ready for release, there will be breaking issues.
