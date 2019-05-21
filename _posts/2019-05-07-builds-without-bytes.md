---
layout: posts
title: "Faster remote builds in Bazel 0.25"
authors:
  - buchgr
---
We are excited to announce the initial availability of ["Remote Builds without the Bytes"](https://github.com/bazelbuild/bazel/issues/6862) in Bazel 0.25.

 
When using Bazel with remote caching and execution it downloads every output file of every action executed (or cached) to the host machine. The total size of all output files in a build will often be in the tens and even hundreds of gigabytes and make the network bandwidth the limiting factor. We know from experience that most of the time developers are only interested in a small subset of the output files produced during a build i.e. the final binary and quite often in a continuous integration build the output files are of no interest at all.
 
We have thus been working on virtualizing action outputs in Bazel so to only transfer file metadata, that is content hash and size, instead of file contents. This will significantly reduce the amount of data being transferred between Bazel and the remote caching or execution system. Our own testing and early user reports suggest build speed improvements of 2x and more are the common case. The specific gains for your project will mostly depend on the available network bandwidth, latency and size of build outputs.

For the initial availability of this performance optimization we have focused on a continuous integration (CI) use case. That is, Bazel will not download any build and test output files and thus Bazel's output base (bazel-out/, bazel-bin/, ...) will be empty after a build. The one exception being that outputs of failed build and test actions (i.e. test.log) will be downloaded in order to make it easier to debug problems.
 
## How to Use It
*This feature is experimental and we do not recommended to enable it on production systems without extensive prior testing.*

You can enable this feature by adding the following three flags to your existing set of remote caching/execution flags:
 
```
--experimental_inmemory_jdeps_files
--experimental_inmemory_dotd_files
--experimental_remote_download_outputs=minimal
```
 
For example, the below invocation will build Bazel remotely without downloading any outputs including the final Bazel binary.
 
```
$ bazel build src:bazel \
    --config=remote \
    --experimental_inmemory_jdeps_files \
    --experimental_inmemory_dotd_files \
    --experimental_remote_download_outputs=minimal
Target //src:bazel up-to-date:
  bazel-bin/src/bazel
INFO: Build completed successfully, 1767 total actions
$ cat bazel-bin/src/bazel
cat: bazel-bin/src/bazel: No such file or directory
```
 
Please note that changing the value of the `--experimental_remote_download_outputs` flag will invalidate all actions and cause a full rebuild. This is working as expected.
 
## Known Issues
 
### Bazel's output base contains dangling symlinks
At the end of a build or test Bazel's output base may contain run file symlinks that point to output files that don't exist locally. We'd expect this to mostly be a cosmetic issue that should go unnoticed by most users. We will fix this over time.
 
### Bazel's persistent action cache will not work
Bazel's on disk cache of the output base does not yet know about remotely stored output files. Thus incremental builds that involve shutting down the Bazel server will be clean builds when using `--experimental_remote_download_outputs=minimal`.
 
```
$ bazel build :foo --experimental_remote_download_outputs=minimal
$ bazel shutdown
# This will be clean build, because the metadata from the previous build are
# not yet properly persisted to disk
$ bazel build :foo --experimental_remote_download_outputs=minimal
```
 
Incremental builds that don't involve a shutdown will work fine. Please follow [#8248](https://github.com/bazelbuild/bazel/issues/8248) for the current state, progress updates and to express interest.
 
### Local file uploads and URI rewriting in the Build Event Service is disabled
When using the build event service (BES) together with remote caching / execution URIs to files are automatically translated to remote URIs pointing to the remote cache. This rewriting is disabled when the `--experimental_remote_download_outputs` flag is set. Users of BEP / BES will see URIs referencing local paths instead of remote paths. Please follow [#8249](https://github.com/bazelbuild/bazel/issues/8249) for the current state, progress updates and to express interest.
 
### Remote build outputs must not be evicted
A remote caching or execution system must not evict outputs during a build. That is an output of the 1st action must still be available to the 1000th action. Before this feature Bazel would simply reupload an output that's been evicted from the remote system but this is no longer possible.
We are working on a solution together with the remote execution community. Please follow [#8250](https://github.com/bazelbuild/bazel/issues/8250) for the current state, progress updates and to express interest.
 
## Future Plans
Bazel 0.26 will additionally support `--experimental_remote_download_outputs=toplevel` which will download only top level outputs (outputs of targets passed to the build / test command). We expect this mode to eventually become the default.
 
In addition to that we are working on solutions for the above mentioned known issues and are eager to learn about your real world experiences!
