workspace(name = "build_bazel_blog")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_website",
    urls = ["https://github.com/bazelbuild/bazel-website/archive/c174fa288aa079b68416d2ce2cc97268fa172f42.tar.gz"],
    strip_prefix = "bazel-website-c174fa288aa079b68416d2ce2cc97268fa172f42",
    sha256 = "a5f531dd1d62e6947dcfc279656ffc2fdf6f447c163914c5eabf7961b4cb6eb4",
    # TODO(https://github.com/bazelbuild/bazel/issues/10793)
    # - Export files from bazel-website's BUILD, instead of doing it here.
    # - Share more common stylesheets, like footer and navbar.
    build_file_content = """
exports_files(["_sass/style.scss"])
"""
)

http_archive(
    name = "rules_pkg",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
    ],
    sha256 = "eea0f59c28a9241156a47d7a8e32db9122f3d50b505fae0f33de6ce4d9b61834",
)
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()