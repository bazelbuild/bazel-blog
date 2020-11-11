---
layout: posts
title: JSON support for persistent workers
authors:
  - susinmotion
---

You asked, we answered -- JSON support for [persistent workers](https://docs.bazel.build/versions/master/persistent-workers.html) is here! 

## Persistent workers in a nutshell

Persistent workers are programs started by Bazel that stay alive throughout the build to execute actions of a particular type. Without workers, Bazel runs each action separately, paying any associated startup costs (like starting the JVM) for every action. Persistent workers enable Bazel to amortize startup costs and allow caching across actions. 

## Why JSON workers?

The original worker implementation required workers to communicate with Bazel using protocol buffers (protobufs). 

This works pretty well at Google, since Bazel is in Java, which has good support for protobufs. In fact, the Bazel code base already depends on protobufs. Additionally, we use remote execution for our builds, leveraging distributed computing resources and taking advantage of cross-user caching, so the fact that the protobuf dependency is large didn’t make much of a difference. 

We didn’t realize at first that requiring this dependency would cause problems for Bazel users who wanted to develop workers. It turns out, though, that requiring workers to communicate via protobufs adds a heavyweight dependency to the worker, which can slow down developing and building the worker itself. In addition, not all languages have robust support for protobufs, which has made it difficult to build workers in languages like Python. 

Users told us about these issues and filed a feature request for workers to be able to communicate via JSON. Why JSON? It’s a standard protocol with robust tooling in almost every language, and it’s human-readable.

## How do I make a worker that uses JSON?

Making a JSON worker is just like [making any other worker](https://docs.bazel.build/versions/master/creating-workers.html), with a few JSON-specific requirements. 

First, the worker needs to read and write JSON-encoded messages when communicating with Bazel. In order to maintain the same backward and forward compatibility properties as protobuf, the worker must also tolerate unknown fields in these messages, and use the protobuf defaults for missing values.

In addition, the execution requirements of the action that uses the worker must include `”requires-worker-protocol” : “json”`.

In order for Bazel to use your newly implemented JSON worker, you must pass `--experimental_worker_allow_json_protocol` to your build (or put `build: --experimental_worker_allow_json_protocol` in your ~/.blazerc). This allows Bazel to communicate with workers via JSON, in addition to proto; it won’t affect Bazel’s interaction with non-JSON workers.

## How can I learn more about workers?

* **Read the docs**: The [persistent worker documentation](https://docs.bazel.build/versions/master/persistent-workers.html) now also includes information about JSON workers.

* **Reach out on [GitHub](https://github.com/bazelbuild/bazel)**: File a bug if you encounter issues creating workers, or if you have feature requests--yours could be the next one implemented, either by the Bazel team or by the community.

* **Register for [BazelCon](https://opensourcelive.withgoogle.com/events/bazelcon2020)!** There’ll be a talk about workers, including live Q and A during the talk. Registration is free!

Like JSON? [Starlark now supports it](https://docs.bazel.build/versions/master/skylark/lib/json.html).
