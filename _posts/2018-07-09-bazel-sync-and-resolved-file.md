---
layout: posts
title: "Bazel sync and resolved files"
authors:
  - aehlig
---

When building against external dependencies, it is often desirable to closely
follow upstream of those projects. On the other hand, reproducible builds can
only be achieved if all dependencies are pinned to specific versions. So
updating the pinned versions becomes a frequent task. We recently added (to
bazel at `HEAD`) a couple of changes to make this task easier. While we have
plans to further improve the workflow of pinning and updating versions of
external dependencies, we encourage everybody to try out the steps below and
provide feedback.

## Return values of repository rules

Say you're trying to follow several git repositories, including `protobuf`. Then
an entry like

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
  name = "com_google_protobuf",
  remote = "https://github.com/google/protobuf",
  branch = "master",
)
```

will follow the active branch `master`. When the rule is actually executed,
it will no longer return `None`, as it has important information to report:
the commit that was actually checked out. More precisely, it will return a dict
with arguments that can be used to obtain the same checkout, even if `master`
moves ahead.

```
{
    "name": "com_google_protobuf"
    "remote": "https://github.com/google/protobuf",
    "commit": "78ba021b846e060d5b8f3424259d30a1f3ae4eef",
    "shallow_since": "2018-02-07",
    ...
}
```

In particular, the `branch` argument is replaced by the appropriate `commit`
argument. A `shallow_since` parameter is added as well, to support cloning that
commit in a shallow way.

## The new flag `--experimental_repository_resolved_file`

To collect the values returned by the repository rules, we added a new option
`--experimental_repository_resolved_file`. If provided, it records in the specified
file all the repository rules that where actually executed, together with their
arguments and return values. The syntax is valid Skylark, so that the file
can be included later in build specifications. To do so, you would check it into
the version control system of your project.

```
resolved = [
    ...,
    {
        "original_rule_class": "@bazel_tools//tools/build_defs/repo:git.bzl%git_repository",
        "original_attributes": {
            "name": "com_google_protobuf",
            "remote": "https://github.com/google/protobuf",
            "branch": "master"
        },
        "repositories": [
            {
                "rule_class": "@bazel_tools//tools/build_defs/repo:git.bzl%git_repository",
                "attributes": {
                    "remote": "https://github.com/google/protobuf",
                    "commit": "78ba021b846e060d5b8f3424259d30a1f3ae4eef",
                    "shallow_since": "2018-02-07",
                    "init_submodules": False,
                    "verbose": False,
                    "strip_prefix": "",
                    "patches": [],
                    "patch_tool": "patch",
                    "patch_args": [
                        "-p0"
                    ],
                    "patch_cmds": [],
                    "name": "com_google_protobuf"
                }
            }
        ]
    }
]
```

As you can see, we collect separately the rule that was originally called,
with its arguments as they were called, and the new rule that is to be called,
which happens to be the same rule in this case, and the new attributes obtained
from the rule for reproducing the same checkout; so `branch` has been replaced
by `commit` and `shallow_since`, and default values have been added. All this
is wrapped in a list to have the format prepared for an extension we plan to
add in the future: rules expanding to several repositories. Those rules do not exist yet,
and bazel is not yet ready to support them, but we're thinking of rules that
handle the interaction with some package manager and then expand to the list
of packages that need to be fetched (maybe simply as `http_archive`s), including
those packages transitively depended upon.

Another use case of the resolved file is a continuous integration system. That
system would always follow the development branch of your project and store
the resolved file for each run, to have enough information for later bisecting
to find the breaking change. That approach is particularly interesting when
testing integration of several independently developed services.

## The new command `bazel sync`

The next building block is a newly added `bazel sync` command. It
unconditionally executes all rules in the `WORKSPACE` file, pretending that
every repository is out of date.
So `bazel sync --experimental_repository_resolved_file=resolved.bzl` will
generate a snapshot of all the repositories mentioned in the `WORKSPACE`.

## Using version snapshots

Now that we know how to generate a file with the frozen commit identifiers,
the last step is to actually read and use them. As the file is Skylark, this
fortunately is not too hard&mdash;we can just import it with a `load` statement.

```
load("//:resolved.bzl", "resolved")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def frozen_repos():
    for entry in resolved:
        for repo in entry["repositories"]:
            if repo["rule_class"] == "@bazel_tools//tools/build_defs/repo:git.bzl%git_repository":
                git_repository(**(repo["attributes"]))
```

To deal with the fact that we may or may not have recorded version snapshots,
we use a function, usually called `maybe`, to just add the external repositories
not yet present.

```
def maybe(repo_rule, **kwargs):
  if kwargs["name"] not in native.existing_rules():
    repo_rule(**kwargs)
```

In the `WORKSPACE` file, we just put those ingredients together.

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("//:maybe.bzl", "maybe")
load("//:frozen_repos.bzl", "frozen_repos")

frozen_repos()

maybe(git_repository,
  name = "com_google_protobuf",
  remote = "https://github.com/google/protobuf",
  branch = "master",
)

...
```

So if `resolved.bzl` contains a pinned version of a repository (identified by
its name), then that version is used; otherwise, the top-level
specification of which branch to follow is used.
To advace to a newer snapshot, simply remove the repositories that should be
freshly synced from the `resolved.bzl` file and `bazel sync` again; in
particular, moving all repositories to a new snapshot is simply
`echo 'resolved = []' > resolved.bzl; bazel sync --experimental_repository_resolved_file=resolved.bzl`.
As `resolved.bzl` is pretty-printed, the diff is meaningful, and could look,
e.g., as follows.

```
diff --git a/resolved.bzl b/resolved.bzl
index 683dd1f..8f25dfa 100644
--- a/resolved.bzl
+++ b/resolved.bzl
@@ -55,8 +55,8 @@ resolved = [
                 "rule_class": "@bazel_tools//tools/build_defs/repo:git.bzl%git_repository",
                 "attributes": {
                     "remote": "https://github.com/google/protobuf",
-                    "commit": "78ba021b846e060d5b8f3424259d30a1f3ae4eef",
-                    "shallow_since": "2018-02-07",
+                    "commit": "79700b56b99fa5c8c22ddef78e6c9557ff711379",
+                    "shallow_since": "2018-03-07",
                     "init_submodules": False,
                     "verbose": False,
                     "strip_prefix": "",
```

After reviewing and testing, that updated `resolved.bzl` file can be committed,
so that everyone can work with the new snapshot in a reproducible way.
