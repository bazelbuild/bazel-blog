---
layout: posts
title: Introducing Bazel Cquery
authors:
  - juliexxia
---

(If you’re already familiar with bazel’s `query` command, skip ahead to the section titled ‘Introducing Cquery’.)

## Querying Your Build
Have you ever wondered why making a certain change causes Bazel to rebuild a seemingly unrelated binary? Have you ever wanted to run a particular subset of tests based on some shared attribute value but didn’t know how to gather them? Or maybe you have targets that work across a variety of platforms and you want to make sure none of them rely on incompatible dependencies? Bazel’s query commands can help remedy such issues.

Bazel uses the [Bazel Query Language](https://docs.bazel.build/versions/master/query.html) to articulate questions such as those listed above. This language includes a set of [functions](https://docs.bazel.build/versions/master/query.html), such as ‘deps’ and ‘somepath’, which can be combined and nested to describe more complex queries. 

The query commands also support a set of flag-based options that govern query behavior. For example, [--noimplicit_deps](https://docs.bazel.build/versions/master/query.html#implicit_deps) limits results to only include targets that are explicitly declared in a BUILD file. The flags also support a selection of [output formats](https://docs.bazel.build/versions/master/query.html#output-formats) for the results of the query, such as a [graph output](https://docs.bazel.build/versions/master/query.html#output-graph) (especially helpful for visualizing the collection of paths between two nodes).

## Introducing `bazel cquery`
Bazel has long supported the `query` command. We’re excited to announce a second* command, `cquery`!

What’s the difference? `query` doesn’t understand build flags and returns all possible answers to a given query expression. `cquery` (configurable query) runs at a later point in the build process, after flag evaluation and [configurable attribute](https://docs.bazel.build/versions/master/be/common-definitions.html#configurable-attributes) resolution. Thus, it can understand [build options](https://docs.bazel.build/versions/master/command-line-reference.html#command-line-reference) and give the answer to a specific Bazel invocation as dictated by its set of flags. Since it runs at a later point, ‘cquery’ is by nature slower than ‘query’.  

`cquery` has yet to reach feature parity with `query`, but as we develop it further, `cquery` will also be able to expose information to which `query` does not have access. See the comparison below for what’s currently supported. 

|                      | `query`                                                                           |`cquery`                                | both                                                                            |
|----------------------|-----------------------------------------------------------------------------------|----------------------------------------|---------------------------------------------------------------------------------|
| Performance          | faster, less acurate                                                              | slower, accurate                       |                                                                                 |
| Functions            | siblings, buildfiles, tests                                                       | config                                 | allpaths, attrs, dep, filter, kind, labels, loadfiles, rdeps, somepath, visible |
| Output Formats       | build, label,  label_kind, minrank, maxrank, location, package, graph, xml, proto | label_and_configuration, transitions** |                                                                                 |
| Options              | query options                                                                     | cquery options, build options          | common query options                                                            |

So, if your priority is speed and over-approximation of results isn’t a problem, `query` is your engine. If your priority is results that match a specific bazel invocation’s flags and fancy output formats aren’t too important to you, then `cquery` is the better choice.

\* Bazel also supports the ‘Sky Query’ engine which automatically kicks in with a specific set of options used with ‘query’. It supports a few extra functions and in some circumstances may be faster and less memory-intensive than ‘query’

\*\* proto output format coming soon!

## Some Motivating Examples

The library //third_party/zlib:zlibonly isn't in the BUILD file for //foo:foo, but it is an indirect dependency. Why?

```
$ bazel query "somepath(//foo:foo, third_party/zlib:zlibonly)"
//foo:foo
//translations/tools:translator
//translations/base:base
//third_party/py/MySQL:MySQL
//third_party/py/MySQL:_MySQL.so
//third_party/mysql:mysql
//third_party/zlib:zlibonly
```

The [Bazel query how-to](https://docs.bazel.build/versions/master/query-how-to.html) contains many common examples of how `query` is used. Many of the examples can also apply to `cquery`. In the following example, we see where `cquery`’s strength lies (properly resolving a [select](https://docs.bazel.build/versions/master/be/functions.html#select) statement).

```
$ cat > tree/BUILD <<EOF
sh_library(
    name = "ash",
    deps = select({
        ":excelsior": [":manna-ash"],
        ":americana": [":white-ash"],
        "//conditions:default": [":common-ash"],
    }),
)
sh_library(name = "manna-ash")
sh_library(name = "white-ash")
sh_library(name = "common-ash")
config_setting(
    name = "excelsior",
    values = {"define": "species=excelsior"},
)
config_setting(
    name = "americana",
    values = {"define": "species=americana"},
)

# Traditional query
$ bazel query "deps(//tree:ash)" --define species=excelsior
...error because query does not understand --define…

$ bazel query "deps(//tree:ash)"
//tree:ash
//tree:white-ash
//tree:manna-ash
//tree:common-ash
…

# cquery
$ bazel cquery "deps(//tree:ash)" --define species=excelsior
//tree:ash (hash-of-config)
//tree:manna-ash (hash-of-config)
...
```

We are constantly working on improving `cquery`! If you have questions or ideas for improvement, contact juliexxia@google.com.
