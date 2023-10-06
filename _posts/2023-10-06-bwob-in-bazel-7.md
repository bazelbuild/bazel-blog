---
layout: posts
title: "Build without the Bytes is enabled by default in Bazel 7"
authors:
  - coeuvre
---

After the many improvements made over past years, we have recently turned on Build without the Bytes by default - **the first release to include this change will be the upcoming Bazel 7 LTS**.

## What is Build without the Bytes?

Remote execution and remote caching are two Bazel features that can be used to improve build performance.

Remote execution allows Bazel to execute build and test actions on remote machines instead of locally. This can improve build performance by allowing multiple machines to work on different parts of the build at the same time.

Remote caching allows Bazel to store the results of build and test actions on a remote server, to share the results of builds and tests across different machines.

In the past, Bazel’s default behaviour was to download every output file of an action after it had executed the action remotely, or hit a remote cache. However, the sum of all output files in a large build will often be in the tens or even hundreds of gigabytes. The benefits of remote execution and caching may be outweighed by the costs of this download, especially if the network connection is poor.

We know from experience that most of the time developers are only interested in a small subset of output files produced during a build, such as the final binary. In a CI build, for example, the output files are often irrelevant.

**BwoB** (Build without the Bytes) allows you to download only a subset of the output files, thus reducing the amount of data transferred between Bazel and the remote caching or execution system. You can enable BwoB by setting either `--remote_download_minimal` or `--remote_download_toplevel`.

## What has been improved?

BwoB was first introduced as an experimental feature in [Bazel 0.25](https://blog.bazel.build/2019/05/07/builds-without-bytes.html). You needed to set `--remote_download_outputs` along with other flags to enable BwoB. We saw over 2x speed up in build performance from the initial implementation, but we also had many [known issues](https://blog.bazel.build/2019/05/07/builds-without-bytes.html#known-issues).

BwoB was then marked as a stable feature in Bazel 1.0 and we added flags `--remote_download_minimal` and `--remote_download_toplevel` which expanded to `--remote_download_outputs` and other required flags so that you only needed to set one of them.

Since then, there were no significant improvements until Bazel 5, when we made BwoB work with Bazel's persistent action cache. Remote actions could now hit the persistent action cache in incremental builds across server restarts. We also introduced the `--remote_download_regex` flag to allow Bazel to download additional output files whose path matches the regex.

In Bazel 6, many improvements had landed, including:

- We made `--remote_download_minimal` more intelligent so it can download a reasonable subset of output files for other commands, such as, run, test, coverage, and more.
- We made `--remote_download_toplevel` work with aspects to support IDE integration.
- We added support for remote cache eviction.
- We added support for remote actions that produce symlinks.

On top of that, we made a massive refactor in Bazel@HEAD to make BwoB more reliable for edge cases. The refactor included the following changes:

- We unified the code paths between `all` and `toplevel`/`minimal`. That is, no matter whether you are building with, or without bytes, Bazel is always running the same code. The removal of this divergence not only improved the code health, but also allowed for faster iterations in the future.
- As a result of this unification, `--remote_download_[minimal|toplevel]` no longer expanded to multiple flags since the codebase was now robust enough that flags that BwoB expanded to became orthogonal to each other. This allows you to easily switch between different output modes without invalidating Bazel's internal cache.
- We completely reworked the invalidation logic. BwoB could now correctly download "missing" files when you switched download modes, top level targets or regexes.
- We also completely reworked the virtual file system used by BwoB. This allows BwoB to handle more edge cases that it couldn't handle before, such as tree artifacts with both local and remote children, symlinks across virtual and local filesystems, and so on.

## Changes in Bazel 7

Starting from Bazel 7, the default download mode will be changed from `--remote_download_all` to `--remote_download_toplevel`. That is, Bazel will no longer download intermediate outputs of remote actions into the local output base. In return, your remote builds will be faster.

### Decide Download Modes

`--remote_download_minimal` only downloads "necessary" output files, which includes inputs to local actions. For `bazel run`, it also downloads required files for the binary to run locally. We highly recommend using `minimal` if you are only interested in build/test results, not the artifacts, such as in a CI build.

`--remote_download_toplevel` will additionally download all outputs of top level targets, which includes outputs from output groups defined by aspects or requested by `--output_groups`. This will be the default mode. Use this mode if you are building interactively and need to consume the final build artifacts.

Furthermore, you can use `--remote_download_regex` to request Bazel to download additional outputs whose path matches the regexes.

If the above options don't work for you, use `--remote_download_all` to force Bazel to download all outputs, as in Bazel 6 and earlier.

| Flag                         | Bazel 7 Default | Necessary Outputs | Toplevel outputs | All outputs |   Example usage    |
| :--------------------------- | :-------------: | :---------------: | :--------------: | :---------: | :----------------: |
| `--remote_download_minimal`  |                 |         ☑         |                  |             |     CI builds      |
| `--remote_download_toplevel` |        ☑        |         ☑         |        ☑         |             | Interactive builds |
| `--remote_download_all`      |                 |                   |                  |      ☑      |      Fallback      |

### Handle Remote Cache Eviction

Remote cache usually has limited storage space so it might have to evict entries based on some strategies. Bazel may throw a `CacheNotFoundException` and exit with code 39 if it tries to download blobs that are already evicted. In this case, just retry the build. Bazel will be able to recover from the error and continue.

You can retry the build manually, having a wrapper that detects the exit code 39 and retry, or setting flag `--experimental_remote_cache_eviction_retries` to let Bazel automatically retry.

If your remote cache evicts blobs based on a fixed TTL, you can tell Bazel the value of TTL by setting `--experimental_remote_cache_ttl` to reduce the chance of remote cache eviction errors.

If your remote cache uses an LRU strategy to evict blobs, you can set the `--experimental_remote_cache_lease_extension` flag to allow Bazel to periodically refresh the lease for blobs that are still referenced by Bazel to reduce the chance that these blobs are evicted.

### No More Flag Expansions

As mentioned above, `--remote_download_[minimal|toplevel]` no longer expand to multiple flags.

`--remote_download_toplevel` was expanded to:

- `--experimental_inmemory_jdeps_files`
- `--experimental_inmemory_dotd_files`
- `--experimental_action_cache_store_output_metadata`
- `--remote_download_outputs=toplevel`

The first three flags have been flipped to true by default and we have also made BwoB work when they are false. So `--remote_download_toplevel` now is simply `--remote_download_outputs=toplevel`.

`--remote_download_minimal` was expanded to:

- `--nobuild_runfile_links`
- `--experimental_inmemory_jdeps_files`
- `--experimental_inmemory_dotd_files`
- `--experimental_action_cache_store_output_metadata`
- `--remote_download_outputs=minimal`

We [decided](https://github.com/bazelbuild/bazel/issues/18580#issuecomment-1701134147) to not couple `--[no]build_runfile_links` with BwoB because it only affects local actions. In the future, we may make it `false` by default. Other flags are similar so `--remote_download_minimal` is now simply `--remote_download_outputs=minimal`.

## Help us test!

These improvements are already landed in [last_green](https://github.com/bazelbuild/bazelisk) or recent [rolling releases](https://github.com/bazelbuild/bazel/releases). Please test them with your projects and report back any issues you encounter. Your help is appreciated!
