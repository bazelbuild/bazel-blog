7---
layout: posts
title: Backward compatibility
---

Bazel is in Beta and we are working hard towards Bazel 1.0 (see the
[roadmap](https://bazel.build/roadmap.html)). We are not there yet, and there
are still many things we want to change, clean, and improve. Future releases of
Bazel will not be 100% compatible with all previous Beta versions. We understand
that breaking changes can be painful for users. That's why we want to make it as
easy as we can to migrate to new Bazel versions.

During the Beta period, we may introduce breaking changes in each minor version
(0.x). Starting with Bazel 1.0, breaking changes will cause a major version
change (1.0, 2.0, etc.). This is known as [Semantic
Versioning](http://semver.org/). Major version changes should not be more
frequent than once a year, and may be less.

For most breaking changes, we will add a flag, e.g. `--incompatible_foo` that is
disabled by default. The flag `--all_incompatible_changes` will enable all of these
flags at once, so you can see whether you're ready for the next major release.

The Bazel team will use the flags as follow:

*   To introduce a breaking change, we release the change along with a new flag
    that is unset by default, e.g. `--incompatible_foo`. This flag enables the
    new behavior, allowing you to test the future change. Flags for incompatible
    features are documented in the section
    [Backward compatibility](https://docs.bazel.build/versions/master/skylark/backward-compatibility.html).

*   At a later release, the new flag is set by default. This
    change is effectively released, so it can happen only at a major version
    (or minor version during Beta). In the release notes, we tell you which
    incompatible changes are enabled. The flag for this change still exists,
    so if needed you can disable it. 

*   Finally, the flag may be removed at any release in the future, and so you will
    no longer be able to disable the behaviour of the change. In the release notes,
    we list these removed flags.

When you migrate to a new release, we recommend the following workflow:

*   Use `--all_incompatible_changes` to ensure your code is
    forward-compatible with the next release. We are aware that you will not
    always be able to fix every issue, for example, there could
    incompatibilities with a repository you depend on.

*   When there is a new Bazel release, try your code again with the
    specific incompatible changes released in the new version. Check the
    release notes to know which flags to use. After verifying your project
    with the released changes, you can update to the new version. Verify
    your project again with the new version, as some small incompatible
    changes are not introduced behind flags.

*   If many users depend on your repository, please update it quickly after each
    Bazel release. This update will help your users test their code.

In all cases, the Bazel team will try to make version updates simple. We will
try to document clearly the changes and provide good error messages. If anything
is unclear, please contact us and we will help you.

To learn more about the changes we are doing, see the
[backward compatibility page](https://docs.bazel.build/versions/master/skylark/backward-compatibility.html).


*By [Laurent Le Brun](https://github.com/laurentlb)*
