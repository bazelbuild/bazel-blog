---
layout: posts
title: "Bazel Hackathon 2018"
authors:
  - edbaunton
---

The day after this year’s [BazelCon](https://conf.bazel.build/2018) at Google New York, Bloomberg hosted 35+ attendees at its Global Headquarters for [a day of hacking](https://conf.bazel.build/2018/hackathon) on all things Bazel, Remote Execution and Remote Worker API.

The event was an opportunity for engineers to meet face-to-face with fellow open source collaborators (many of whom had only ever previously communicated via email or GitHub) to hack on open issues, build enhancements and simply discuss their ideas in an informal and relaxed setting.

Engineers from Bloomberg, Codethink, Dropbox, Etsy, Google, Uber, VMware and more collaborated on Bazel enhancements and bugfixes, as well as remote execution client and server implementations (Such as [BuildFarm](https://github.com/bazelbuild/bazel-buildfarm), [BuildGrid](https://gitlab.com/BuildGrid/buildgrid) and [recc](https://gitlab.com/bloomberg/recc)). Ideas were exchanged, bugs were squashed and documentation was clarified. Below is a selection of just some of the things that were worked on during the hackathon.

We look forward to seeing you at next year’s BazelCon!

<img src="/assets/bazel-hackathon.jpg" alt="Bazel Hackathon in progress" class="img-responsive">

## What was Hacked On?

Below is a sample of just a few of the issues that were worked on during the Hackathon.

After the talk at BazelCon by Two Sigma, support was added into [BuildBox](https://gitlab.com/BuildStream/buildbox/merge_requests/9) and recc for reading extended attributes for digests from the filesystem. This can provide significant performance improvements for builds that frequently require the checksum of their inputs; instead of rereading the entire file and calculating the checksum each time, the filesystem can provide it on update using FUSE.

Alongside the BuildGrid maintainers, Paul Cody Johnston’s ([@pcj](https://github.com/pcj)) [BuildKube](https://groups.google.com/forum/#!topic/bazel-discuss/pPNIc9-liCE) was enhanced to support spinning up a cluster of BuildGrid and Buildbarn servers and workers in order to make it easier to get started with remote execution from Bazel using Kubernetes.

Progress was made on a long-outstanding [issue](https://github.com/bazelbuild/bazel/pull/5928) related to the git repository cache by [@unapiedra](https://github.com/unapiedra) and Klaus Aehlig ([@aehlig](https://github.com/aehlig)). The complexities of this thorny issue were much easier to clarify and work on face-to-face.

[Clarifications](https://github.com/bazelbuild/remote-apis/pull/30) were added to the Operations API of remote execution by Ola Rozenfeld ([@ola-rozenfeld](https://github.com/ola-rozenfeld)), along with Martin Blanchard ([@t-chaik](https://github.com/t-chaik)), to make it simpler and cleaner.

[BuildStream](https://gitlab.com/BuildStream/buildstream) was tested against Google’s new Remote Build Execution service, further demonstrating the potential of the protocol. This will add a fourth publically available open source RBE client alongside Bazel, Pants and recc.

Gregg Donovan of Etsy was able to seamlessly update their production version of Bazel to 0.17.2 from 0.16.1. In addition, he got their Bazel builds working using Google’s new RBE service -- both build and test are running in the cloud!

With help from Ulf Adams ([@ulfjack](https://github.com/ulfjack)) from the Bazel team, Uber’s George Gensure ([@werkt](http://www.github.com/werkt)) was able to have a [commit](https://github.com/bazelbuild/bazel/pull/6365/files) to Bazel approved during the hackathon! This commit, which was applied the next day, improved the performance of Bazel when it comes to the creation of symlink trees.

A fix was (filed)[https://github.com/bazelbuild/bazel/pull/6360] against Bazel by Mark Zeren ([@mzeren-vmw](https://github.com/mzeren-vmw)) for a longstanding bug with C/C++ Toolcahins that was merged later by Ulf Adams ([@ulfjack](https://github.com/ulfjack)).

Andreas Osowski ([@th0br0](https://github.com/th0br0)) made a [contribution](https://github.com/bazelbuild/bazel-buildfarm/pull/190) to BuildFarm to improve the validation of actions when requeueing in order to improve the stability of BuildFarm. It was merged during the hackathon by George Gensure ([@werkt](http://www.github.com/werkt)).
