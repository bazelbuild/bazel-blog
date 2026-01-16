---
layout: posts
title: "Postmortem for *.bazel.build SSL certificate expiry"
authors:
 - wyv
---

On 2025-12-26, at 07:35 UTC, the SSL certificates for many `*.bazel.build` domains expired. This resulted in widespread build breakages for many Bazel users, as several crucial domains serve essential functionality used by nearly all Bazel builds. It was reported by users on [GitHub](https://github.com/bazelbuild/bazel/issues/28101), [Slack](https://bazelbuild.slack.com/archives/CA31HN1T3/p1766739655375159), and the [bazel-discuss](https://groups.google.com/g/bazel-discuss/c/pnxWzgE_UbU) mailing list. The outage lasted for approximately 13 hours before being resolved.

## Impact

The majority of the impact was Bazel builds in CI environments breaking due to the following domains being inaccessible:

* `releases.bazel.build`: This domain hosts Bazel release binaries and serves as the primary source for Bazelisk to fetch specific versions of Bazel. The majority of builds failed immediately at this stage, as CI environments often don't have a Bazel binary cached locally.
* `bcr.bazel.build`: This is the Bazel Central Registry (BCR), which serves metadata Bazel uses to resolve external dependencies. Access to the BCR is required unless the lockfile is up to date and the download cache is primed, the latter of which is often not set up for CI environments.
* `mirror.bazel.build`: This is a mirror that hosts copies of source archives for certain popular Bazel projects. Users who managed to work around the unavailability of the previous two domains could nevertheless be unable to build because of this mirror being down.

## Background

The Bazel team at Google operates a number of websites under the `bazel.build` domain. These domains are backed by various underlying systems; for example, `bazel.build` itself is currently hosted on the same backend that powers the [Google Developers](https://developers.google.com/) site, and `registry.bazel.build` is currently hosted on GitHub Pages.

Most other subdomains (including `releases`, `bcr`, and `mirror`) are hosted on Google Cloud Platform (GCP). They each statically serve files from a Google Cloud Storage (GCS) bucket, and share a [Compute Engine Google-managed SSL certificate](https://docs.cloud.google.com/load-balancing/docs/ssl-certificates/google-managed-certs). These are the subdomains impacted by the outage.

A Google-managed SSL certificate is set up to cover a list of domains, and is valid for 90 days. About one month before expiry, an auto-renewal process triggers, which checks the validity of each of the domains it covers and provisions a renewed certificate. Crucially, *every* domain needs to be reachable before the renewed certificate is provisioned.

## Timeline of outage

*All times are UTC unless otherwise noted.*

* On 2023-02-23, a new Google-managed SSL certificate was set up to cover all GCP-hosted `*.bazel.build` domains, including `releases`, `bcr`, `mirror`, and `docs-staging.bazel.build`. The certificate then went on to auto-renew successfully for the next 2+ years.
* On 2025-10-30, a change was submitted to our DNS records to remove the `docs-staging.bazel.build` subdomain, which was no longer used.
* Around 2025-11-26, the auto-renewal process for the Google-managed SSL certificate kicked off. This process went on to fail repeatedly due to `docs-staging.bazel.build` no longer being accessible. However, these failures never triggered any notifications.
* **[Outage start]** On 2025-12-26, at 07:35:39, the certificate expired. Affected Bazel builds immediately started failing.
* At 09:00, a user reported build breakages to the [Bazel Slack server](https://bazelbuild.slack.com/archives/CA31HN1T3/p1766739655375159). At 09:01, a user filed an issue on [Bazel's GitHub repo](https://github.com/bazelbuild/bazel/issues/28101).
* At 12:15, a Bazel team member based in Munich noticed the GitHub issue and posted a message in the team chat group. The team member was out of office and could not help investigate.
* At 15:08 (10:08 Eastern Time), a Bazel team member based in New York started investigating.
* In the next few hours, two more team members based in New York joined the investigation and attempted various mitigation approaches, initially without success.
* **[Outage end]** At 20:31, a new SSL certificate was finally set up and propagated to all necessary frontends. Access to all affected domains was restored.
* At 20:32, the resolution was communicated to users on GitHub, Slack, and the bazel-discuss mailing list.

## What went wrong

* **No alerting**
    * The Google-managed SSL certificate renewal failures did not trigger any notifications.
    * Moreover, the Bazel team didn't have alerting set up for SSL certificate expiry, despite a [previous similar outage](https://github.com/bazelbuild/bazel/issues/15515) having left an action item to set up alerts. The action item remained unprioritized and unaddressed until this outage.
* **Unfortunate timing and lack of expertise**
    * The outage happened during the winter holidays, when many Bazel team members (including the entire team based in Munich, where Dec 26th is a public holiday) were on vacation. The outage also happened at 2am in New York, way before any team members started working.
    * Only a small fraction of team members were familiar with the infrastructure used to manage the bazel.build domain, and the team member with the most expertise was completely unavailable. Other teams whose expertise might have been helpful were also mostly OOO, so we had to investigate on our own.
* **Outdated or insufficient documentation**
    * The Bazel team's internal documentation for managing SSL certificates included instructions to set up a manual certificate in case of emergency, but this turned out to be a red herring as this manual certificate system had already been deprecated. The instructions also involved requesting a specific permission that only some team members on vacation could grant, which led to more wasted time.
    * The documentation did not mention that deleting a subdomain's DNS records required creating a new Google-managed certificate, nor were there any automated checks in place to keep these in sync.
* **Poor error messaging and GCP complexity**
    * When a new Google-managed certificate is set up but fails to provision, it provides no error message to suggest *why* the provision failed. The GCP documentation offers a [troubleshooting page](https://docs.cloud.google.com/load-balancing/docs/ssl-certificates/troubleshooting) that lists a number of potential failure modes, which meant that the incident responders had to investigate every single one.
    * In the end, it turned out that the new SSL certificate had to be associated with both IPv4 and IPv6 "target proxies".
* **Slow provisioning process**
    * SSL certificates naturally take a long time (up to 45 minutes) to provision and propagate. Coupled with the trial-and-error nature of the investigation, this time cost had to be paid repeatedly, lengthening the duration of the outage.
    * What made this more confusing was that the provisioning had transient states of failure: the provisioning process could report a state of `FAILED_NOT_VISIBLE` but still return to `ACTIVE` after as many as 30 minutes. This made it very difficult to tell how long we had to wait.

## Where we got lucky

* Despite not being perfect, the documentation from the previous similar outage was immensely helpful for the resolution of the new outage.
* Many community members stepped up to offer mitigation strategies, including [@AliDatadog](https://github.com/DataDog/datadog-agent/pull/44621), [@lshirui](https://github.com/bazelbuild/bazel/issues/28101#issuecomment-3692747741), and [@blackliner](https://github.com/bazelbuild/bazel/issues/28101#issuecomment-3693126654). (See also "Recommendations for Bazel users" below.)

## Next steps

To prevent similar outages from happening in the future, we're taking the following steps:

* **Set up alerting**: We have set up a GitHub Actions [workflow](https://github.com/bazelbuild/bazel/blob/master/.github/workflows/ssl-monitor.yml) to detect when SSL certificates are nearing expiry and file issues ([example](https://github.com/bazelbuild/bazel/issues/28201)) to notify Bazel team members. We're also looking into setting up a prober to report general access issues with resources.
* **Improve internal documentation and automation**: We've removed the outdated instructions from our internal documentation. Changes to add or remove DNS records will now require creating a new Google-managed SSL certificate with a matching domain list.
* **Recommendations for Bazel users**: We've [updated our recommendations](https://bazel.build/external/faq#how-do-i-insulate-my-builds-from-the-internet) for Bazel users to insulate themselves from potential outages of this kind. This includes properly populating the download cache and ensuring the lockfile is up to date in CI environments, and hosting internal mirrors for Bazel release binaries, BCR metadata, and source archives.

## See also

* [The dangers of SSL certificates](https://surfingcomplexity.blog/2025/12/27/the-dangers-of-ssl-certificates/) by Lorin Hochstein
* [December 2025 Bazel Central Registry Outage](https://blog.engflow.com/2026/01/05/december-2025-bazel-central-registry-outage/) by John Cater