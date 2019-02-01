---
layout: posts
title: "Bazel - a multi-language build system"
authors:
  - laurentlb
---

Part of [Bazel vision](https://docs.bazel.build/versions/master/bazel-overview.html)
is to create a multi-language build system: it should be possible to seamlessly
use and mix multiple languages in a codebase and to orchestrate builds and
tests with a single build tool. As a codebase gets bigger, this feature
becomes more and more important.

When a user wants a build system to be multi-language, they might mean:

*   Is the build system extensible? In other words, can I add support for a new
    language, even if it doesn't have much adoption yet, or if it is internal?
*   How many languages are already supported?
*   How big is the ecosystem?
*   Does it provide a high level of quality for the languages I use?
*   Can I use it in production?

Bazel allows you to [create your own rules](https://docs.bazel.build/versions/master/skylark/concepts.html).
More importantly, however, it allows rules to communicate and pass information
using "providers." For example, if a rule depends on a C++ library, it might
need to access the appropriate headers or the compiled library. This is
extensible, because rules declare what they expect from their dependencies. Any
rule implementing that interface (that is, returning the correct providers) will
be accepted as a dependency. For this reason, the ecosystem can grow and you can
create new rules that interact with existing rules.

Many rules exist for Bazel. A company like Google has more than a thousand
internal rules, created by many teams, sometimes just for a single project, to
handle their specific needs. Many other rules are public and shared in places
like GitHub. The [Awesome-Bazel](https://github.com/jin/awesome-bazel#rules)
page lists Bazel rules for many languages and tools. If you use a well-known
language, it's likely you'll find an existing rule for it.

However, quantity doesn't imply quality. As with any open-source code published
on the Internet, there is no guarantee that a repository is properly designed
and maintained. To help users, we want to promote a set of high-quality rules
that they can trust. Our website lists [a few external rules](
https://docs.bazel.build/versions/master/be/overview.html#additional-rules), but
we are working on a more principled process for recommendations - for example,
we should recommend only rules that we have properly tested.

It's hard to find an objective measure of quality, but we can look at the
user base of each rule. Some of them are actively maintained and used in
production. For example, companies like Lyft and LinkedIn rely on the Swift
rules. C++ rules are widely used by comaponies and projects, such as
[Tensorflow](https://github.com/tensorflow/tensorflow).
[Salesforce](https://www.youtube.com/watch?v=V8HayK90PI4) migrated to Bazel to
build their Java codebase, Two Sigma uses Rust, while Square is experimenting
with the Kotlin rules. The Scala rules are used by multiple companies, including
[Wix](https://www.youtube.com/watch?time_continue=7&v=wCkqtM44BvU), Stripe,
Meetup, and Spotify. [Tweag](https://www.youtube.com/watch?v=20fYYDwiNqw) has
been developing Haskell rules and has migrated several of their customers to
Bazel. Bazel can also build mobile applications, such as the
[Pinterest](https://www.youtube.com/watch?v=wewAVF-DVhs) iOS application, or
[Tensorflow](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/examples/android)
for Android.

This suggests that Bazel is a multi-language build system and can be useful and
extensible beyond the few languages it originally supported.
