---
layout: posts
title: Backward compatibility
---

Bazel is in Beta and we are working hard towards Bazel 1.0 (see
[roadmap](https://bazel.build/roadmap.html)). We are not there yet, and there
are still many things we want to change, clean, and improve. Future releases of
Bazel will not be 100% compatible with all previous Beta versions. We understand
that breaking changes can be painful for users. That's why we want to make it as
easy as we can for users to migrate to new Bazel versions.

During the Beta period, we may introduce breaking changes in each minor version
(0.x). Starting with Bazel 1.0, breaking changes will cause a major version
change (1.0, 2.0, etc.). This is known as [Semantic
Versioning](http://semver.org/). These version changes should not be more
frequent than once a year, and may be less.

For each breaking change, we will add a flag, e.g. `--incompatible_foo` that is
disabled by default. The flag `--all_incompatible_changes` will enable them all
at once, so you can see whether you're truly ready for the next major release.

The Bazel team will use the flags as follow:

*   Each time we want to introduce a breaking change, we first add a new option
    (unset by default) `--incompatible_foo`, that enables the new behavior. This
    allows any user to test the future change.

*   Later, the new option will be set by default. This is effectively a breaking
    change, so it can happen only at a major version (or minor version during
    Beta). In the release announcement, we tell you which incompatible changes
    are enabled.

*   Finally, the option may be removed at any time in the future.

When users migrate to a new release, we recommend the following workflow:

*   Please try `--all_incompatible_changes` to ensure your code is
    forward-compatible with the next release. We are aware that you will not
    always be able to fix every issue: there can be a problem with a repository
    you depend on.

*   When there is a new Bazel release, try your code again with
    `--incompatible_` (check the announcement to know which options
    to use). If the build is successful, you can safely update to the new
    version.

*   If many users depend on your repository, please update it quickly after each
    Bazel release. This will help your users test their code.

In all cases, the Bazel team will try to make version updates simple. We will
try to document clearly the changes and provide good error messages. If anything
is unclear, please contact us and we will help you.

To learn more about the changes we are doing, see the
[backward compatibility page](https://docs.bazel.build/versions/master/skylark/backward-compatibility.html).


_By [Laurent Le Brun](https://github.com/laurentlb)_
