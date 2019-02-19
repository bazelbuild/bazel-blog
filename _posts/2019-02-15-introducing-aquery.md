---
layout: posts
title: Introducing Bazel Aquery
authors:
 - joeleba
---

_tl;dr: [`bazel aquery`](https://docs.bazel.build/versions/master/aquery.html) is a new bazel command that queries the action graph, and thus allows you to gain insights about the actions executed in a build (inputs, outputs, command line, …).
`aquery`’s API is now stable and supported by the Bazel team._

## Why `bazel aquery`?

_"What was the command line that produced this output file?"_

_"Did the new change in my rule implementation affect the current list of actions?"_

_"What was the exact command line used to run action X?"_

Those are some of the questions which can be answered with `aquery`. The `aquery` command allows you to query for actions to be executed in your build. It operates on the post-analysis Action Graph and exposes information about Actions, Artifacts and their relationships.

`aquery` is already being used in our various workflows. An example usage of `aquery` can be found in the Bazel issue [#6861](https://github.com/bazelbuild/bazel/issues/6861), where we are migrating legacy CROSSTOOL fields. In this case, Bazel users would run a migration tool, and then use `aquery` to verify that the migration tool works properly, in particular:

- The actions generated while building the same target before & after running the migration tool are the same.
- The command lines run for each action are the same.

The specific usage is implemented in [`aquery_differ` tool](https://github.com/bazelbuild/bazel/blob/master/tools/aquery_differ/aquery_differ.py). This also serves as an example of how tools can be built on top of `aquery`.

## Background & Motivation

Apart from providing the ability to build & test your projects, Bazel also offers insights into how those processes happen with [`query`](https://docs.bazel.build/versions/master/query-how-to.html) and [`cquery`](https://docs.bazel.build/versions/master/cquery.html). These existing tools have been very helpful with answering the questions about dependencies of targets in your Bazel project.

The Bazel build process consists of 3 phases<sup>[1](#footnote1)</sup>: Loading, Analysis and Execution. `query` operates on the post-loading phase target graph, which makes it unaware of the configurations of these targets. `cquery` moves it further down the building process and queries the post-analysis Configured Targets, thus includes the actual configurations.

The topology of the Configured Target Graph closely resembles the dependency graph of targets established by the BUILD files. It offers information on the dependency between targets in a build, but not on the actual build actions that will be run to execute that build. To gain insights on the exact actions executed in a build, we have to go one level deeper, to the Action Graph.

Enter `aquery`.

![bazel queries and phases](/assets/bazel-queries.png)

`aquery` runs on the Configured Target Graph and queries the Action Graph. The Action Graph<sup>[2](#footnote2)</sup> is the result of the Analysis Phase. It is a bipartite graph with the following types of nodes:

- Artifacts: either a source file or any output file produced by an action
- Actions: the functional step that takes a list of Artifacts as input and outputs a list of Artifacts. Note that any (output) artifact is produced by exactly one action. The Action Graph conveys explicit step-by-step instructions on how the build would be executed.

With `aquery`, it is now possible to tap into that knowledge.

## `bazel aquery`

`aquery` is useful when we are interested in the properties of the Actions/Artifacts in the Action Graph. The basic structure of `aquery` output is as follows:

```
$ bazel aquery '//some:label'
action 'Writing file some_file_name'
  Mnemonic: ...
  Owner: ...
  Configuration: ...
  ActionKey: ...
  Inputs: [...]
  Outputs: [...]
...
```

Each action entry encapsulates all the information you need to know about how this action is to be executed: the actual commands run, the configuration in which the action is run, its input/output artifacts, and other attributes.

Another nifty feature in `aquery` is the ability to filter the actions based on their inputs, outputs and mnemonics. This is useful to answer questions like: “Which action, from which target, is responsible for creating file foo.out”.

```
# List all actions generated while building all dependencies of //src/target_a
$ bazel aquery 'deps(//src/target_a)'

# List all actions generated while building all dependencies of //src/target_a
# that have C++ files in their inputs.
$ bazel aquery 'inputs(".*cc”, deps(//src/target_a))'

# Which action generated `foo.out` after building all dependencies of target //src/target_a
$ bazel aquery ‘outputs(“.*foo.out”, deps(//src/target_a))’
```

Apart from these basic features, `aquery` offers customizations for your specific use cases with its various flags and tools.

### Output Formats
`aquery` supports 3 different output formats: `text` (default, human-readable with formatting), `proto` and `textproto` (a human-readable representation of the proto output).

### `--skyframe_state`
A common use case of `aquery` is to find the action responsible for generating a particular file `foo.out`. However, it is often the case that multiple build commands for different targets were run prior to the query, and the user might not remember all the targets that were built.

The flag `--skyframe_state` comes in handy in such situations.

```
# Find all actions on skyframe that has “foo.out” as an output
bazel aquery --skyframe_state --output=proto ‘outputs(“*.foo.out”)’
```
More details on this flag can be found [here](https://docs.bazel.build/versions/master/aquery.html#skyframe-state).

### Comparing Aquery Outputs With `aquery_differ`

There are times when there’s a need to compare two different `aquery` outputs (for instance: when you make some changes to your rule definition and want to verify that the command lines being run is still the same). [`aquery_differ`](https://docs.bazel.build/versions/master/aquery.html#diff-tool) is the tool for that.

```
bazel run //tools/aquery_differ -- \
--before=/path/to/before.proto \
--after=/path/to/after.proto
--input_type=proto
--attrs=cmdline
--attrs=inputs
```

The above command returns the difference between the `before` and `after` `aquery` outputs (e.g. which actions were present in one but not the other, which actions have different command line/inputs in each `aquery` output, ...). 

---

For more details on `aquery`, check out the [aquery documentation](https://docs.bazel.build/versions/master/aquery.html).

_<a name="footnote1">1</a>: In the actual implementation of Bazel, we interleave Loading & Analysis phases. The “Target Graph” at the end of Loading phase is only materialized with `bazel query` and not in actual builds._

_<a name="footnote2">2</a>: For a more detailed overview of the Action Graph, check out [Jin’s](https://github.com/jin) [blog post](https://jin.crypt.sg/articles/bazel-action-graph.html)._
