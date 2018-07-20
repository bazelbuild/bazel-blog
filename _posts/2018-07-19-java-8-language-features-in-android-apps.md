---
layout: posts
title: "Java 8 Language Features in Android Apps"
authors:
  - kevin1e100
---

__tl;dr:__ With Bazel, you can use Java 8 language features and APIs such as lambdas, default and static interface methods, sequential streams, optionals, and java.time in your Android apps!

Android apps built with Bazel can use Java 8 language features and still support legacy Android devices!  That’s remarkable because devices running Android versions prior to Nougat don’t come with any support for Java 8, and lambda expressions don’t have runtime support even on the latest devices.  Bazel uses what we call __desugaring__ to allow apps to use Java 8 language features and select Java 8 language APIs anyway.  A [previous post](/2018/02/28/incremental-dexing.html) shows how desugaring fits into the larger picture of Android builds with minimal build performance impact; in this post we go into detail on how it works and how to use it.

Desugaring, in a nutshell, converts Java 8 bytecode into equivalent (modulo reflection, more on that later) bytecode that can be executed on any Android devices.  As a result, the desugared language features are usable in source code but encoded with equivalent, older constructs in the resulting app’s binary code.  Here’s a summary of how desugaring of different Java 8 language features looks like (we’ll discuss Java 8 language APIs afterwards):

* __Lambda expressions and method references__ use a relatively new Java bytecode instruction, *invokedynamic*, to invoke a so-called “bootstrap method” that generates and loads a class at runtime.  The generated class looks a lot like the anonymous inner class one would’ve written with Java 7.  Desugaring involves generating that class ahead of time and replacing the invokedynamic instruction with an instantiation of the generated class.  The [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern) design pattern is used for stateless lambdas.
* __Default methods__ are made abstract in the interface that declares them.  Their implementations are moved to a synthetic helper class and classes implementing an interface with default methods get any missing methods stubbed in.  Fun fact: this stubbing is often needed in classes generated for lambda expressions.
* __Static interface method__ declarations are similarly moved to a helper class and their call sites rewritten to target the helper class.
* __Type annotations__ don’t have a runtime representation on Android devices, so they can be used in source code and are visible to the compiler, but they’re ignored at runtime.

Bazel applies all of these by default but ignores default and static interface methods that are pre-installed on newer devices.  When building with `--experimental_desugar_java8_libs`, however, some of those default methods, such as `java.util.Collection.stream()`, together with new language APIs introduced with Java 8, become usable as well.  Bazel currently supports a handful of commonly used Java 8 language APIs, including:

* Sequential streams (parallel streams work on Lollipop and newer devices)
* `java.time`
* `java.util.function`
* Recent additions to `java.util.{Map,Collection,Comparator}`
* Optionals and some other new classes useful with the above APIs

Please submit feature requests for other APIs you’d like to use.  Bazel will include implementations of these APIs as a separate `.dex` file into your app and desugar your app to still work on older devices (requires multidex).

Taken together, you can use all Java 8 language features as well as a number of standard language APIs introduced with Java 8 anywhere in your Android apps, regardless of what version of Android your app is run on.  To make this work at scale, Bazel separately desugars each `.jar` file that goes into your app.  And because desugaring operates on bytecode, Bazel supports the use of Java 8 language features in third-party libraries you want to include in your app as well as in other languages compiling to bytecode: Java 8 language features used in the resulting Jars will be desugared as well.

One caveat is that desugaring can perturb runtime reflection information.  For instance, the list of methods declared by classes implementing interfaces with default methods can contain extra entries.  Also, Java 8 language APIs will in some cases exhibit suboptimal behavior; for instance, date-time formatting options newly introduced with Java 8 won’t always work.
