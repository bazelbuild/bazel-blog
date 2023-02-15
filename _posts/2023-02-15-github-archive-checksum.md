---
layout: posts
title: GitHub Archive Checksum Outage
authors:
  - wyv
---

On 2023-01-30, many Bazel users encountered build errors due to [a change in GitHub's source archive generation mechanism](https://github.blog/changelog/2023-01-30-git-archive-checksums-may-change/). The change, since rolled back, caused all source archives (_not_ release archives) to have a different checksum, despite their contents being unchanged. This caused an outage for several package management systems that relied on stable checksums, including Bazel.


## What went wrong

GitHub allows repo maintainers to upload _release archives_ for each release. These are generated and uploaded by the repo maintainer, and are always served as-is. Additionally, GitHub allows users to download _source archives_ for each tag, which are generated on-demand using `git archive` and are thus sensitive to changes in Git.

![The two types of archive downloads on GitHub: release archives (stable) and source archives (unstable)](/assets/github-archives.png)

Bazel has recommended archives downloaded from the Internet to be checked against an explicit SHA-256 checksum. Based on past discussions with GitHub, the Bazel team held the belief that the source archives (served under the `/archives/refs/tags` URLs) were guaranteed to have stable checksums, and thus recommended that such URLs be used in the `source.json` file in the Bazel Central Registry. However, when GitHub updated its Git version to one with a different default compression algorithm, it changed the checksums of all dynamically generated source archives. All Bazel users who relied on GitHub source archives having a stable checksum encountered build breakages.


## What to do as a rule author

The rule authors SIG has [changed the rules template](https://github.com/bazel-contrib/rules-template/pull/44) to recommend using release archives instead of source archives. If you're a rule author, you should follow this advice by creating release archives, and advise your users to switch.

In the future, we'll work on further validation checks in the Bazel Central Registry to make sure these unstable source archive URLs are not permitted in `source.json` files.


## What to do as a Bazel user

If you're using the `WORKSPACE` file, for any of your direct dependencies from GitHub, consider using a release archive instead of a source archive, if available.

If you're using Bzlmod and have a custom registry, you can use the [`mirrors`](https://bazel.build/external/registry#index_registry) attribute of the `bazel_registry.json` file to specify a custom mirror with artifacts that you control.

Furthermore, consider joining our community-moderated [Slack server](https://slack.bazel.build), where you can engage in discussions with other Bazel users, and be notified when similar outages happen.


## Further reading

* GitHub discussions on the [initial breakage](https://github.com/orgs/community/discussions/45830) and [community requirements](https://github.com/orgs/community/discussions/46034)
* [How GitHub's upgrade broke Bazel builds](https://jayconrod.com/posts/127/how-github-s-upgrade-broke-bazel-builds) by Jay Conrod

