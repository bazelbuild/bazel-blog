---
layout: posts
title: Introducing Bazel Cquery
---

You have probably used Bazel’s [`query`](https://docs.bazel.build/versions/master/query.html) command to inspect and monitor your build to resolve issues. Today, in addition to the `query` and `skyquery` engines, we are introducing their more accurate sibling command, [`cquery`](https://docs.bazel.build/versions/master/cquery.html).

`Cquery`'s increased accuracy stems from the fact that it runs after the second phase of a bazel build, the [analysis phase](https://docs.bazel.build/versions/master/user-manual.html#analysis-phase) while `query` and `skyquery` run after the first phase, the [loading phase](https://docs.bazel.build/versions/master/user-manual.html#loading-phase). The analysis phase is when [configurable attributes](https://docs.bazel.build/versions/master/be/common-definitions.html#configurable-attributes) (i.e. attributes with `select` statements) are evaluated and resolved. Thus, `query` and `skyquery` can only return all possible answers across all potential build invocations, but `cquery` understands build options and returns the results of a specific bazel invocation.

See the comparison below:

|                      | `query`                                                                           | `skyquery`                                              |`cquery`                              | all                                                                             |
|----------------------|-----------------------------------------------------------------------------------|---------------------------------------------------------|--------------------------------------|---------------------------------------------------------------------------------|
| Time of Execution    | post-loading phase                                                                | post-loading phase                                      | post-analysis phase                  |                                                                                 |
| Functions            | siblings, buildfiles, tests                                                       | allrdeps, rbuildfiles                                   | config                               | allpaths, attrs, dep, filter, kind, labels, loadfiles, rdeps, somepath, visible |
| Output Formats       | build, label,  label_kind, minrank, maxrank, location, package, graph, xml, proto | build, label, label_kind, location, package, xml, proto | label_and_configuration, transitions |                                                                                 |
| Options              | query options                                                                     | query options                                           | cquery options, build options        | common query options                                                            |

`Cquery` does not yet have feature parity with `query`, but we’re constantly working on improving it. If you have any questions or ideas for its growth, contact juliexxia@google.com.
