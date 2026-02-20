---
layout: posts
title: "Dependabot Now Supports Bazel Version Updates"
authors:
 - robaiken
 - markhallen 
 - honeyankit
---

We're thrilled to announce Bazel support in Dependabot Version Updates! 🎉 Through a collaboration between the Bazel and Dependabot teams, along with feedback from both communities, Dependabot now handles both Bzlmod and WORKSPACE dependencies with proper lockfile generation.

## The Journey to Bazel Support

Since 2019, the community has been asking for Bazel support in Dependabot ([issue #2196](https://github.com/dependabot/dependabot-core/issues/2196)). When the Dependabot team began building this, they reached out to the Bazel community in [discussion #27142](https://github.com/bazelbuild/bazel/discussions/27142) to understand what mattered most. The feedback was clear: proper lockfile generation is critical, `*.MODULE.bazel` support is needed, and many teams are still on WORKSPACE. Even though WORKSPACE is approaching end-of-life, supporting it was the right call because that's where many users still are today.

## Why Bazel Support Is Challenging

Bazel presents unique challenges that make dependency management more complex than other ecosystems:

**Two Dependency Systems:** Bazel has both the modern Bzlmod system (using MODULE.bazel files) and the legacy WORKSPACE system. Each works differently, and teams are at various stages of migration between them. Even though WORKSPACE is being phased out, community feedback showed many teams still rely on it. Support for both systems was essential.

**Non-Trivial Lockfile Generation:** Bazel's MODULE.bazel.lock files capture complex transitive dependency graphs including module extensions and repository rules, which goes beyond typical package manager lockfiles. Getting lockfile generation wrong breaks reproducible builds, so Dependabot worked closely with the Bazel community to ensure we got this right.

**Community Migration in Progress:** While Bzlmod is the future (enabled by default in Bazel 8), a significant number of users still rely on WORKSPACE. Supporting both ensures users are met where they are.

## Built in Partnership with Bazel

This feature came together through close collaboration between the Dependabot and Bazel teams and community:

- **Lockfile semantics:** Fabian Meumertzheim worked closely with the Dependabot team to ensure their lockfile generation matches Bazel's behavior exactly
- **Registry integration:** Understanding how to properly query and use the Bazel Central Registry
- **Migration patterns:** The Bazel team shared insights into how real teams are moving from WORKSPACE to Bzlmod
- **Testing and validation:** Yun Peng provided invaluable support and data to validate Dependabot's implementation
- **File naming conventions:** Alex Eagle helped clarify the `*.MODULE.bazel` pattern and other edge cases

A big thank you to everyone in both communities who tested this and provided feedback. This wasn't just us building a feature; it was a true partnership from start to finish.

## How It Works

**Dependency Detection:** Dependabot scans your `MODULE.bazel` and `*.MODULE.bazel` files (or WORKSPACE) for dependencies and checks the Bazel Central Registry for updates.

**Lock File Management:** When updating dependencies, Dependabot properly regenerates lock files to maintain reproducible builds, the most critical piece to get right.

**Pull Requests:** Dependabot opens PRs with updated dependency declarations, regenerated lock files, release notes, and compatibility information.

## Getting Started

To enable Dependabot for your Bazel project, you'll need:

**Bazel Version:** Your project must be using Bazel 7, 8, or 9, as these are the supported versions.

**Project Configuration:** A MODULE.bazel or WORKSPACE file is required at the root of your repository.

**Dependabot Integration:** Add the Dependabot configuration by creating a `.github/dependabot.yml` file and including the necessary YAML configuration.

```yaml
updates:
  - package-ecosystem: "bazel"
    directory: "/"
    schedule:
      interval: "weekly"
```

**Customization (Optional):** All standard Dependabot configuration options are available, including custom schedules, grouped updates, and dependency ignores. See the [Dependabot options reference](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/dependabot-options-reference) for details.

Once configured, Dependabot will start watching your Bazel dependencies and opening PRs when updates are available.

## Try It Out

Bazel support is now generally available to all Dependabot and Bazel users. Check out the [changelog](https://github.blog/changelog/2025-12-16-dependabot-version-updates-now-support-bazel/) on Github and [Dependabot's documentation for getting started](https://docs.github.com/en/code-security/tutorials/secure-your-dependencies/dependabot-quickstart-guide).

We're excited to see how this helps the Bazel community keep their dependencies secure and up-to-date. Open source is a team sport, and this feature is proof of what's possible when teams work together across projects.