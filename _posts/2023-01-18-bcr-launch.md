---
layout: posts
title: Bazel Central Registry Launched!
authors:
  - meteorcloudy
---

We're thrilled to announce the official launch of the Bazel Central Registry (BCR). As the default Bazel registry for the [Bzlmod](https://bazel.build/versions/6.0.0/build/bzlmod) external dependency system, which enters general availability with Bazel 6.0, the BCR is the recommended place to publish and discover Bazel modules.

![Image](/assets/bcr-ui.png)

The BCR makes managing external dependencies in Bazel projects easier than ever. As a centralized registry, it is maintained via [the BCR Github repository](https://github.com/bazelbuild/bazel-central-registry), which is mirrored to https://bcr.bazel.build, and offers a user-friendly web interface at https://registry.bazel.build for searching and browsing existing modules. To contribute to the BCR, please follow [the BCR contribution guidelines](https://github.com/bazelbuild/bazel-central-registry/blob/main/docs/README.md#bazel-central-registry-bcr-contribution-guidelines).

We're are looking forward to see the Bazel community migrate to Bzlmod and the BCR, and we can't wait to see the new modules that will be published in the coming weeks and months. We'd like to extend our gratitude to the Bazel community for their involvement in developing and testing the BCR. The BCR will continue to be maintained by both the Bazel team and the community in the future.
