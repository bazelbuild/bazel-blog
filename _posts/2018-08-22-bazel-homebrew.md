---
layout: posts
title: "Bazel in Homebrew"
authors:
  - buchgr
---

As of Bazel 0.16.0, all official Bazel releases have been using an embedded JDK.
An embedded JDK allows us to exhaustively test Bazel itself on a specific JDK
version and removes the need for users who don't use Bazel to build Java to
install their own JDK.

Bazel is currently in [homebrew core](https://github.com/homebrew/homebrew-core)
which does not allow one to [include binaries](https://github.com/Homebrew/brew/blob/master/docs/Acceptable-Formulae.md#we-dont-like-binary-formulae)
in a formula but instead requires all binaries to be built from source. This
policy is not compatible with embedding a JDK and so we have made the decision
to move out of homebrew core and instead provide our very
[own homebrew tap](https://github.com/bazelbuild/homebrew-tap).

You can make homebrew use our tap by (one time) running the below commands

```bash
$ brew tap bazelbuild/tap
$ brew tap-pin bazelbuild/tap
```

Having added our tap you can install Bazel via the install command

```bash
$ brew install bazel
```

and upgrade to a newer version via the upgrade command

```bash
$ brew upgrade bazel
```

Please note that if you have installed Bazel from the homebrew core formula in
the past you will have to uninstall it first by running `brew uninstall bazel`.
Thanks [Jason Gavris](https://github.com/jgavris) for pointing this out!
