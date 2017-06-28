---
layout: posts
title: Strict Java Deps and `unused_deps`
---

This blog post describes how Bazel implements "strict deps" for Java compilations ("SJD"), and how it is leveraged in [`unused_deps`](https://github.com/bazelbuild/buildtools/blob/799e530642bac55de7e76728fa0c3161484899f6/unused_deps/unused_deps.go), a tool to remove unused dependencies. It is my hope this knowledge will help write rules for similar JVM-based languages such as Scala and Kotlin.

## What's "Strict Deps"?

By "strict deps", we loosely mean that all directly used classes are loaded from jars provided by a rule's direct dependencies. In other words, if a Java file mentions another class, then it must be reflected in the BUILD file.  
(the concept is similar to Buck's "first-order dependencies")

```java
class A {
  void foo(B b) { }  // <---- B is used, therefore we must depend on :B
}
```

```python
java_library(
    name = "A",
    srcs = ["A.java"],
    deps = [":B"], # <--- this dependency is required
)
```
Note that any dependencies of `B` itself are *not* listed in the `deps` of `A`.

The initial motivation for SJD was the ability to remove unused dependencies.

Consider a dependency chain `A -> B -> C` without strict deps. It's impossible to know if `C` can be removed from `B`'s `deps` just by looking at it - all transitive users of `B` must be considered to make this decision.
Strict deps mandates that if `A` also uses `C`, it must depend on it directly, therefore making it safe to remove `C` from `B`'s `deps`.

## `unused_deps`

[`unused_deps`](https://github.com/bazelbuild/buildtools/blob/799e530642bac55de7e76728fa0c3161484899f6/unused_deps/unused_deps.go) is a tool to remove dependencies that aren't needed from a `java_library` (and other Java rules).

When Bazel builds a Java rule `:Foo` on the command line, it writes two files - [`Foo.jar-2.params`](https://github.com/bazelbuild/bazel/blob/3759d00356e7bf1dcf42e34cb83ad7bf3153a9c2/src/main/java/com/google/devtools/build/lib/rules/java/JavaCompileAction.java#L656) and `Foo.jdeps`. The former contains the command-line arguments to the Java compiler and the latter contains a serialized [src/main/protobuf/deps.proto](https://github.com/bazelbuild/bazel/blob/3759d00356e7bf1dcf42e34cb83ad7bf3153a9c2/src/main/protobuf/deps.proto) which specifies which jars were loaded during compilation. 

[`unused_deps`](https://github.com/bazelbuild/buildtools/blob/799e530642bac55de7e76728fa0c3161484899f6/unused_deps/unused_deps.go) loads the two files and figures out which rules aren't needed in a rule's `deps` attribute, and emits [Buildozer](https://github.com/bazelbuild/buildtools/tree/799e530642bac55de7e76728fa0c3161484899f6/buildozer) commands to delete them.

## Implementation

Bazel always passes the entire transitive classpath to `javac`, not only the direct classpath. This frees the user from having to aggregate their transitive dependencies manually. In other words, `javac` never fails because of a missing symbol, as long as every rule specifies its direct dependencies.
This is done at [JavaCompileAction.java#L729](https://github.com/bazelbuild/bazel/blob/3759d00356e7bf1dcf42e34cb83ad7bf3153a9c2/src/main/java/com/google/devtools/build/lib/rules/java/JavaCompileAction.java#L729).

SJD is enforced by a compiler plugin implemented in  [StrictJavaDepsPlugin.java](https://github.com/bazelbuild/bazel/blob/3759d00356e7bf1dcf42e34cb83ad7bf3153a9c2/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/javac/plugins/dependency/StrictJavaDepsPlugin.java). When Bazel constructs the command-line to `javac`, it specifies [which jars come from indirect dependencies](https://github.com/bazelbuild/bazel/blob/3759d00356e7bf1dcf42e34cb83ad7bf3153a9c2/src/main/java/com/google/devtools/build/lib/rules/java/JavaCompileAction.java#L377) using the `--indirect_dependency` flag. The plugin then walks the `.java` sources and reports any symbols that come from indirect jars.   
(A sketch of how it works: The compiler stores the name of the jar from which a symbol was loaded. The plugin walks the AST after the type annotation phase, and stops at each 'type expression', then checks whether the originating jar is an `--indirect_dependency`. If it is the plugin generates an error message. The message includes the missing direct dependency to add.)

This approach has the advantage that violations are easy to fix - Bazel tells the user exactly what to do. 

## Summary

* Bazel passes all jars from the **transitive** dependencies of a rule.
* Bazel notifies the SJD compiler plugin which jars are indirect.
* During compilation, the compiler plugin reports any symbol mentioned in the Java file that is loaded from an indirect jar.

*By [Carmi Grushko](https://github.com/cgrushko)*
