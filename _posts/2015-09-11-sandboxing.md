---
layout: posts
title: About Sandboxing
authors:
  - ulfjack
  - philwo
---

*This post was updated on 2017-12-19 to remove outdated information that caused
frequent misunderstanding of Bazel's sandboxing feature.*

We've only added sandboxing to Bazel two weeks ago, and we've already seen a
flurry of fixes to almost all of the rules to conform with the additional
restrictions imposed by it.

## What is sandboxing?
Sandboxing is the technique of restricting the access rights of a process. In
the context of Bazel, we're mostly concerned with restricting file system
access. More specifically, Bazel's file system sandbox will run processes in
a working directory that only contains known inputs, such that compilers and
other tools can't even see source files they should not access, unless they
know the absolute paths to them.

Note that sandboxing does not try to hide the host environment in any way.
Processes can freely access all files on the file system. However we try to
prevent them from modifying any files outside their working directory. This
requires platform-specific features though and is only available on newer
Linux versions that support user namespaces and on macOS.


## Why are we sandboxing in Bazel?
We believe that developers should never have to worry about correctness, and
that every build should result in the same output, regardless of the current
state of the output tree. If a compiler or tool reads a file without Bazel
knowing it, then Bazel won't rerun the action if that file has changed, leading
to incorrect incremental builds.

We would also like to support remote caching in Bazel, where incorrect reuse of
cache entries is even more of a problem than on the local machine. A bad cache
entry in a shared cache affects every developer on the project, and the
equivalent of 'bazel clean', namely wiping the entire remote cache, rather
defeats the purpose.

In addition, sandboxing is closely related to remote execution. If the build
works well with sandboxing, then it will likely work well with remote
execution - if we know all the inputs, we can just as well upload them to a
remote machine. Uploading all files (including local tools) can significantly
reduce maintenance costs for compile clusters compared to having to install the
tools on every machine in the cluster every time you want to try out a new
compiler or make a change to an existing tool.


## How does it work?
On Linux, we're using user namespaces, which are available in Linux 3.8 and
later. We use mount namespaces to make parts of the file system read-only
and PID namespaces for reliable process management.

On Mac, we use `sandbox-exec`, which is supplied with the operating system.
Unfortunately no mechanism like PID namespaces or Subprocess Reapers seems
to exist on macOS, so we couldn't get process management to work reliably
so far.

On Windows, we currently do not implement sandboxing.

