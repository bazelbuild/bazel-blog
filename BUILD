load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("//scripts:jekyll.bzl", "jekyll_build")

# Required to move the file from the external repo's execroot location
# to the _sass location expected by the local css/main.scss imports.
genrule(
    name = "style-common",
    srcs = ["@bazel_website//:_sass/style.scss"],
    outs = ["_sass/style.scss"],
    cmd = "cp $< $@",
)

filegroup(
    name = "jekyll-srcs",
    srcs = glob(
        ["**/*"],
        exclude = [
            ".git/**",
            "bazel-*/**",
            "BUILD",
            "WORKSPACE",
            "scripts/**",
            "*.swp",
            "LICENSE",
            "CONTRIBUTING.md",
            "production/**",
            "README.md",
        ],
    ) + [":style-common"],
)

pkg_tar(
    name = "jekyll-files",
    srcs = [":jekyll-srcs"],
    strip_prefix = ".",
)

pkg_tar(
    name = "bootstrap-css",
    srcs = ["//third_party/css/bootstrap:bootstrap_css"],
    package_dir = "assets",
    strip_prefix = "/third_party/css/bootstrap",
)

pkg_tar(
    name = "bootstrap-images",
    srcs = ["//third_party/css/bootstrap:bootstrap_images"],
    package_dir = "assets",
    strip_prefix = "/third_party/css/bootstrap",
)

pkg_tar(
    name = "font-awesome-css",
    srcs = ["//third_party/css/font_awesome:font_awesome_css"],
    package_dir = "assets",
    strip_prefix = "/third_party/css/font_awesome",
)

pkg_tar(
    name = "font-awesome-font",
    srcs = ["//third_party/css/font_awesome:font_awesome_font"],
    package_dir = "assets",
    strip_prefix = "/third_party/css/font_awesome",
)

pkg_tar(
    name = "bootstrap-js",
    srcs = ["//third_party/javascript/bootstrap:bootstrap_js"],
    package_dir = "assets",
    strip_prefix = "/third_party/javascript/bootstrap",
)

pkg_tar(
    name = "jekyll-tree",
    deps = [
        ":bootstrap-css",
        ":bootstrap-images",
        ":bootstrap-js",
        ":font-awesome-css",
        ":font-awesome-font",
        ":jekyll-files",
    ],
)

jekyll_build(
   name = "site",
   srcs = [":jekyll-tree"],
)
