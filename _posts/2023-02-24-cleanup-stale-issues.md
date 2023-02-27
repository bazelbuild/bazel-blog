---
layout: posts
title: "Improving the health of Bazel’s orphaned issues and PRs"
authors:
 - radvani
 - meteorcloudy
 - keertk
---

Over the past few years, we have noticed several languishing issues and pull requests on repositories across the [Bazel GitHub organization](https://github.com/bazelbuild). While some have stalled without updates from authors, others have languished due to limited bandwidth and resources on the Bazel team’s end. In late 2022, we prioritized an effort to periodically review old issues/PRs and close them out as needed. Our apologies for the late communication on this process.

**Goal:** Close issues/PRs older than 6 months that haven't been addressed and are unlikely to be addressed at the current state, in order to sustainably manage and maintain the growing backlog.

**Repository targeted:** [bazelbuild/bazel](https://github.com/bazelbuild/bazel)

_(Note: we implemented a slightly similar process for [bazelbuild/intellij](https://github.com/bazelbuild/intellij) as well.)_

**Details:**

- We have implemented a stale workflow using GitHub Actions to notify users of inactivity in an issue/PR before closing as stale.
- The bot will review all issues/PRs that are older than 3 years and close them out 14 days after a notification. After the first pass is complete, we’ll move on to more recent issues (2 years, 1 year, etc.) before eventually settling at 6 months. This phased process minimizes notifications and avoids loss of important comments.
- Please note that all issues with priority P0 and P1 will be excluded from the stale workflow. Additionally, issues/PRs that are tagged as “untriaged”, ”awaiting-bazeler”, “awaiting-review”, “awaiting-PR-merge”, or “not stale” will be excluded from the stale workflow.

**Our ask:** If you think any issue/PR that we flag as “**stale**” is still something relevant or you are interested in getting the issue resolved, please let our triage team know by tagging @bazelbuild/triage in a comment. The triage team will review the issue with the appropriate team at Google and reopen or suggest next steps.

Over the past few weeks, we might have closed some issues and PRs that are still relevant, and our only intent was to truly understand those that need our attention so we can refocus our resources where we can be most impactful. Our apologies for the inconvenience caused. As we continue with this process, we might close out issues simply based on issue age and inaction. We would like to hear from you - please reach out to product@bazel.build.

Thank you for your support and understanding.
