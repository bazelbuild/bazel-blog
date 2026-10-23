---
layout: posts
title: "Bazel releases addressing the eMudhra CA compromise"
authors:
 - wyv
---

The Bazel team has published new releases of Bazel and Bazelisk to address the recent disclosure of the [eMudhra intermediate CA private key compromise](https://emudhra.we-have-a-problem.com/). The following Bazel releases remove the distrusted eMudhra and Sectigo AAA root CA certificates from the bundled JDK:

* [7.7.2](https://github.com/bazelbuild/bazel/releases/tag/7.7.2)
* [8.8.2](https://github.com/bazelbuild/bazel/releases/tag/8.8.2)
* [9.3.1](https://github.com/bazelbuild/bazel/releases/tag/9.3.1)
* [10.0.0rc2](https://github.com/bazelbuild/bazel/releases/tag/10.0.0rc2)

If you cannot immediately upgrade to one of the patched releases above (or are using an older, unsupported Bazel release), you can work around the issue by passing `--host_jvm_args=-Djavax.net.ssl.trustStore=<path>` to point Bazel's JVM at an updated trust store that excludes the distrusted roots.

We have also released [Bazelisk v1.30.0](https://github.com/bazelbuild/bazelisk/releases/tag/v1.30.0), built with Go 1.27.3 to address [CVE-2026-111943](https://go.dev/issue/82345).

Thanks to community member James Sharpe for bringing this issue to our attention.
