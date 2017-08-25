---
layout: posts
title: Introducing sandboxfs
---

**sandboxfs** is a new project to improve the way sandboxing works in Bazel
by making it more efficient and correct.  It's experimental and subject to
change, but it's available now for you to check out! Read on for details.

# Correct builds

As our motto claims, *correctness* is an integral part of Bazel. To achieve
correctness, builds must be *hermetic* and
[*reproducible*](https://reproducible-builds.org/), which means that all
actions invoked by Bazel should be run in a well-defined environment. In
other words: we want actions to run within a sandbox.

Let's consider an example. Think of a `cc_library` target that specifies
`foo.cc` as a source. This `cc_library` rule contains a *compilation
action* that, for this target, turns the `foo.cc` source file into a
`foo.o` object file.  This action will run clang, and it will need to:

*  read `foo.cc`,
*  read all the headers required by `foo.cc`,
*  write `foo.o`, and
*  possibly write some temporary files under `/tmp/`.

To be confident this build is correct, Bazel must ensure that the action
has read-only access to the identified input files and write-only access to
the output and temporary files we expect. Otherwise, Bazel cannot know if
the compiler went astray and read random files from the system, making
future builds inconsistent. One way to achieve these restrictions is by
running each action within a sandbox.

# Current sandboxing techniques

Today, Bazel uses different technologies to implement the sandboxing of
actions. For example, on Linux, Bazel uses PID- and mount-namespaces, and
on macOS, Bazel uses symlinks and the `sandbox(7)` facility. Note that
sandboxing is disabled by default.

However, all these approaches have scalability and performance issues. A
typical build action requires hundreds, if not thousands, of files and
directories to be mapped into the sandbox. Setting these up takes time. On
macOS, this approach is especially problematic because Bazel must create
thousands of symlinks every time it invokes an action, and this is slow.

To make things worse, these approaches also have correctness issues. If
symlinks are used, some tools (e.g. some compilers or linkers) will decide
to extract the real path of such symlinks and work off that path. These
tools may end up "discovering" and consuming undeclared files that are
siblings of the symlink's target.

# Enter sandboxfs

To resolve these issues, we came up with the idea of implementing a FUSE file
system that allows us to *define an arbitrary view of the host's file system
under the mount point*. We call this approach **sandboxfs**.

## sandboxfs is efficient

The view sandboxfs offers is cheaply configured at mount time. With
sandboxfs there is a single system call to configure the mount point versus
thousands of symlink creation and deletion system calls.

The view can also be reconfigured cheaply across different actions,
avoiding the need to remount the FUSE file system on each action, which
would also be costly.

## sandboxfs is correct

The view sandboxfs offers is fully virtual, so sandboxfs can enforce
arbitrary read-only and read/write access permissions on any file or
directory it exposes. Similarly, because the view is virtual, there are no
symlinks involved. sandboxfs exposes real files and directories to the
actions, so actions cannot reach into the original locations.

# Isn't FUSE slow though?

Yes. As you may know, [FUSE is slower than a real file
system](https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf).
This difference is because of the overhead of message-passing between the
kernel and userspace, and because of all the context switches that are
involved in serving a file system operation.

Our hypothesis is that, because builds are generally not I/O bound, the
increased cost of I/O within the sandbox will pay for itself when compared
to the cost of setting up and tearing down the sandbox for each action.  No
more creating thousands of symlinks or defining thousands of mount points.

But for now, that's all that it is: a hypothesis. We haven't finished
stabilizing the sandboxfs code base, which means we haven't profiled nor
tuned it. The integration points with Bazel are still being defined and
implemented, which means it's not yet trivial to test-run Bazel's
sandboxing with sandboxfs.

# But it's here!

Though still in development, there is no reason to keep the code hostage
any longer. We are very happy to announce that, as of today, it's now
available as an open-source project under the Bazel umbrella! See:

> [https://github.com/bazelbuild/sandboxfs/](https://github.com/bazelbuild/sandboxfs/)

Keep in mind that this project is still an experiment and highly subject to
change. In particular, be aware that the command line and the data formats
are most certainly going to mutate (for simplicity if anything). But the
current code is now sufficient to experiment and play with.

As sandboxfs is now an open-source project, please take a look and report
any features you would like to see, any bugs you encounter, and...  if you
decide to delve into the code and address any of the many `TODO`s in it,
feel free to send us your Pull Requests!

Enjoy!

Special credits go to [Pallav Agarwal](https://github.com/pallavagarwal07),
whom we had the pleasure of hosting over a summer internship in the Google
NYC office and who wrote the initial version of sandboxfs.

*By [Julio Merino](http://julio.meroh.net/)*
