# Bazel blog

This repository hosts the content of the [Bazel](https://bazel.build) blog, available at https://blog.bazel.build/

## Writing a new blog post

Send a Pull Request adding a file to [https://github.com/bazelbuild/bazel-blog/tree/master/_posts](https://github.com/bazelbuild/bazel-blog/tree/master/_posts)
using the following filename format: `<year>-<month>-<day>-<title>.md` This filename format
is required by the Jekyll processor.

Begin your post with the following lines:

```
---
layout: posts
title: <whatever>
authors:
  - username1  # See _config.yml for the list of authors.
  - username2
---
```

If you omit the layout, the blog post will not be formatted properly. If you
omit the title, it won't have a title.

Write the body of your post below the "---". If you have headers in your post,
use H2 and smaller headers (in makedown H2 is denoted by `##`).

## Prerequisites

To build the site, you will need [Jekyll](http://jekyllrb.com) version 2.5.3 or
above. For instance, it can be installed with `apt-get install jekyll` on recent
Ubuntu (tested on 16.10).

To deploy the site, you will need [gsutil](https://cloud.google.com/storage/docs/gsutil)
and to authenticate with `gcloud auth login`.

### Using Docker container

Or you can run a Docker container to avoid setting up Jekyll locally:

```
docker run --rm -it --entrypoint bash -v <path-to-bazel-blog>:/opt -w /opt -p 4000:4000 gcr.io/bazel-public/docgen
```

## Running the website locally

To stage the site, run `bazel run //:site`.

See [the Jekyll site](http://jekyllrb.com/docs) if you need more info.

## Deploying the website

The website is deployed automatically after new commits are merged into the `master` branch. 
The update time is around 30 mins - ping (bazel-dev@googlegroups.com) in case of problems.
