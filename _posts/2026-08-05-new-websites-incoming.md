---
layout: posts
title: "New bazel.build websites incoming!"
authors:
 - fwe
 - wyv
---

We're happy to announce the launch of the new bazel.build documentation site and the new web UI for the Bazel Central Registry!

## New documentation site

Last year, Alan Mond wrote a viral [blog post](https://alanmond.com/posts/bazel-documentation-improvements/) that highlighted the issues with Bazel's documentation site. This led to his [Let's Build the Future of Bazel Documentation](https://docs.google.com/document/d/1R-02--2NQuu2TR7covDTqNMExMhjHfPS-YHoqOweaqk/edit?usp=sharing) birds-of-a-feather session at BazelCon 2025, where we decided to overhaul the documentation completely.

Alan and a group of volunteers from the community and Google have now completed the first and most significant milestone by migrating [https://bazel.build](https://bazel.build) from a proprietary Google hosting site to [Mintlify](https://www.mintlify.com/). This step improves the experience for contributors and readers alike:

* It's easier to make (significant) changes to the docs since we now use the [well-documented](https://mdxjs.com/docs/) .mdx format.  
* Moreover, contributors can now generate a preview of their changes either locally or by using the new automated PR preview feature ([example](https://github.com/bazelbuild/bazel/pull/30344#issuecomment-5169190960)).  
* For readers, Mintlify offers AI features such as an embedded assistant that allows them to prompt the docs directly. 

Documentation content continues to live in the [bazelbuild/bazel](https://github.com/bazelbuild/bazel) GitHub repository next to the Bazel source code. The new [bazel-contrib/bazel-docs](https://github.com/bazel-contrib/bazel-docs) repository contains the documentation pipeline and the navigation.

There are still some rough edges that we plan to address in the near future. Known issues are being tracked [here](https://github.com/bazelbuild/bazel/issues/30598) - please post a comment when you encounter a bug.

We hope that the new website makes it easier for external developers to contribute to the documentation, especially when it comes to significant changes like revamping the structure or adding new pages such as codelabs and tutorials. Consequently, we welcome anyone to contribute to these efforts - please check [https://bazel.build/contribute/docs](https://bazel.build/contribute/docs) for instructions, or visit us in the [#documentation Slack channel](https://bazelbuild.slack.com/archives/CRH3QF91B).

## New BCR UI

Community member [Paul Johnston](https://github.com/pcj) has built an entirely new web UI for the Bazel Central Registry at [https://registry.bazel.build/](https://registry.bazel.build/). The new site brings several improvements over the previous one:

* **Detailed overview**: The new site features a denser display of key information about the module, including its dependencies, maintainers, and other versions. It also puts the prose documentation of the module front and center, pulled directly from the README.md file of the corresponding GitHub repo.  
* **Smarter information retrieval**: Beside pulling README files, the new site has quite a few new tricks up its sleeve. It tries to surface official API documentation from the module, and if it's missing, it runs Stardoc on the .bzl files automatically and surfaces the result. It also presents the attestations and presubmit configs associated with each module version.  
* **Powerful search and indexes**: Beyond searching for modules by their names, you can also search by symbols - try searching for `go_library`. You can also view the list of available modules filtered by their primary language or maintainers.  
* **Faster UI update times**: Module authors should expect quicker updates to the BCR UI. When new commits land in the BCR GitHub repo, a repository dispatch triggers a new BCR UI build that takes on average less than 5 minutes.  The new static assets are deployed to GitHub Pages in another 1-2 minutes.  
* **Other tidbits**: The new site has many other corners to explore. One of them is the [Bazel flags page](https://registry.bazel.build/bazel/flags), which lists all the command-line flags present in the past few Bazel LTS releases. For each individual flag, it also tells you which Bazel versions it is present in, and which Bazel subcommands it applies to.

Please take it for a drive, and file issues and send PRs to [https://github.com/bazel-contrib/bcr-frontend](https://github.com/bazel-contrib/bcr-frontend)!

Finally, a huge thank you again to all community members who contributed to these efforts, especially Kayce Basques, Alex Eagle, Paul Johnston, Alan Mond, Armando Montanez, Anthony Pratti, Nikki Vijaybhaskar and Kapunahele Wong - they wouldn't have been possible without you!
