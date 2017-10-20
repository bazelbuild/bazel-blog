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
title: Lorem ipsum dolor sit amet
---
```

Keep in mind:

*   If you omit the `layout:` part, the post will not be formatted properly.
*   If you omit the `title:` part, the post won't have a title.
*   You may not use a colon (":") in the title.
*   Write the body of your post below the "---".

    If you have headers in your post, use H2 and smaller headers (in makedown H2
    is denoted by `##`).

## Running the website locally

To stage the site, run `./scripts/serve-docs.sh `.

See http://jekyllrb.com/docs if you need more info.

## Pushing changes to https://blog.bazel.build/

The blog is hosted on Google Cloud Storage, and we use Jekyll to render the
Markdown pages to HTML.

The following steps describe the manual process of pushing the blog:

1.  Install Jekyll 3.

    If you can't install Jekyll on your workstation because of security policy:

    1.  Open the Google Cloud Console website.
    2.  SSH into a Ubuntu 16.04 CI machine.
    3.  Install Jekyll.

        ```sh
        sudo apt-get install jekyll
        ```

2.  Download and install the [Google Cloud
    SDK](https://cloud.google.com/sdk/docs/quickstart-linux).

3.  Authenticate with `gcloud`.

    ```sh
    gcloud auth login
    ```

4.  Clone https://github.com/bazelbuild/bazel-blog

    ```sh
    git clone https://github.com/bazelbuild/bazel-blog.git
    ```

5.  Build `//:jekyll-tree`.

    If you SSH'd to a CI machine, you can use the Bazel binary that the CI
    machine uses:

    ```sh
    cd ~/bazel-blog
    /home/ci/.bazel/bin/bazel build //:jekyll-tree
    ```

6.  Unpack the resulting file to tempdir.

    ```sh
    export JEKYLL_TEMP="$(mktemp -d)"
    cp bazel-bin/jekyll-tree.tar "$JEKYLL_TEMP"
    cd "$JEKYLL_TEMP"
    tar xf jekyll-tree.tar
    ```

7.  Build the site using Jekyll.

    This step renders the Markdown to HTML.

    ```sh
    cd "$JEKYLL_TEMP"
    jekyll build
    ```

8.  Push the site to GCS.

    ```sh
    export BUCKET="gs://blog.bazel.build"
    cd "$JEKYLL_TEMP/production"
    # Rsync:
    #   -r: recursive
    #   -c: compute checksum even though the input is from the filesystem
    gsutil rsync -r -c "$PWD" "$BUCKET"
    gsutil web set -m index.html -e 404.html "$BUCKET"
    gsutil -m acl ch -R -u AllUsers:R "$BUCKET"
    ```

# Troubleshooting

## Blog looks like raw Markdown code

You may have accidentally pushed the Markdown files instead of HTML. The server
cannot render Markdown so it displays the raw file.

To fix:

1.  Rebuild and repush the Jekyll site as explained above.
2.  Check from an incognito window that the blog looks fine.
