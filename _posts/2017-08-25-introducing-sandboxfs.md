---
layout: posts
title: Introducing sandboxfs
---

As our motto claims, *correctness* is an integral part of Bazel. To achieve
correctness, builds must be *hermetic* and
[*reproducible*](https://reproducible-builds.org/), which means that all
actions invoked by Bazel should be run in a well-defined environment. In other
words: we want actions to run within a sandbox.

To better illustrate this point, let's consider an example: think of a C++
`cc_library` target that specifies `foo.cc` as a source. This target contains a
*compilation action* that turns the `foo.cc` source file into a `foo.o` object
file. This action will run clang, will need to read `foo.cc`, will need to read
the transitive closure of all headers required by `foo.cc`, will need to write
`foo.o`, and may need to write some temporary files under `/tmp/`.

Under these conditions, Bazel must ensure that the action only has read-only
access to the input files we identified and write-only access to the output and
temporary files we expect. The reason for this is because, unless these
conditions are enforced, Bazel cannot know that the output file really came
from those inputs: it may well be that the compiler went astray and read random
files from the system, which means further builds would be inconsistent.

# Current sandboxing techniques

Today, Bazel uses different technologies to implement the sandboxing of
actions. For example, on Linux, Bazel uses PID- and mount-namespaces, and on
macOS uses symlinks and the `sandbox(7)` facility. (Note: sandboxing is
disabled by default.)

However, all these approaches have scalability and performance issues. The
reason is that a typical build action requires hundreds, if not thousands, of
files and directories to be mapped into the sandbox, and setting these up takes
time. This is especially problematic on macOS: on this platform, Bazel must
create thousands of symlinks every time it invokes an action, and this is slow.

To make things worse, these approaches also have correctness issues: if
symlinks are used, some build tools will decide to extract the real path of
such symlinks and work off that path, which means that they may end up
"discovering" and consuming undeclared files that are siblings of the symlink's
target.

# Enter sandboxfs

To resolve these issues, we came up with the idea of implementing a FUSE file
system that allows us to *define an arbitrary view of the host's file system
under the mount point*. We call this **sandboxfs**.

sandboxfs is efficient: the view it offers is cheaply configured at mount time
(think that there is a single system call to configure the mount point versus
thousands of symlink creation and deletion system calls). The view can also be
reconfigured cheaply across different actions, avoiding the need to remount the
FUSE file system on each action (which would also be costly).

sandboxfs is correct: the view it offers is fully virtual, so sandboxfs can
enforce arbitrary read-only and read/write access permissions on any file or
directory it exposes. Similarly, because the view is virtual, there are no
symlinks involved: sandboxfs exposes real files and directories to the actions,
so those cannot reach into the original locations.

# Isn't FUSE slow though?

Yes. As you may know, [FUSE is slower than a real file
system](https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf)
because of the overhead of message-passing between the kernel and userspace,
and because of all the context switches that are involved in serving a file
system operation.

Our hypothesis is that, because builds are (generally) not I/O bound, the
increased cost of I/O within the sandbox will pay for itself when compared to
the cost of actually setting up and tearing down the sandbox for each action
(no more creating thousands of symlinks nor defining this many mount points).

But for now, that's all that it still is: just a hypothesis. We haven't
finished stabilizing the sandboxfs code base yet, which means we haven't
profiled nor tuned it; and the integration points with Bazel are still being
defined and implemented, which means it's not yet trivial to test-run Bazel's
sandboxing with sandboxfs.

# But it's here!

No matter what, there is no reason to keep the code hostage any longer, so we
are very happy to announce that, as of today, it's now available as an
open-source project under the Bazel umbrella! See:

> https://github.com/bazelbuild/sandboxfs/

Keep in mind that this is still an experiment and highly subject to change. In
particular, be aware that the command line and the data formats are most
certainly going to mutate (for simplicity if anything). But, regardless, the
current code is now sufficient to experiment further and play with.

Enjoy!

Special credits go to [Pallav Agarwal](https://github.com/pallavagarwal07),
whom we had the pleasure of hosting over a summer internship in the Google NYC
office and who wrote the initial version of sandboxfs.

*By [Julio Merino](http://julio.meroh.net/)*
