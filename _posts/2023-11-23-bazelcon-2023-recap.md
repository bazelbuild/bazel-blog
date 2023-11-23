---
layout: posts
title: "BazelCon 2023 Recap: Recordings and Birds of a Feather Session Notes"
authors:
  - meteorcloudy
---

Last month, we hosted [BazelCon 2023](https://blog.bazel.build/2023/05/25/save-the-date-bazelcon2023.html) in Munich, Germany, marking the first-ever [BazelCon](https://blog.bazel.build/2023/05/25/save-the-date-bazelcon2023.html) in Europe.

We received a record number of 120 proposals submitted by the community this year. A heartfelt thank you to the community members who generously devoted their time in the selection process and all speakers who put their dedication and effort into preparing great talks!

Equally heartwarming was the opportunity to connect with everyone in person. The event sparked numerous valuable and productive conversations that would just not happen online.

We want to express our gratitude to everyone in our community for attending our annual Bazel Conference and making it a success!

As promised, recordings of all main stage talks and notes of Birds of a Feather sessions are now published:

## Recordings ([full playlist](https://www.youtube.com/playlist?list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj))

* [BazelCon Keynote](https://youtube.com/watch?v=bAz3d2qV9UI&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=1&pp=iAQB)
* [State of the Union](https://youtube.com/watch?v=XqOpwlns-D8&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=2&pp=iAQB)
* [Empyrean Evaluation](https://youtube.com/watch?v=RYC6OycnGYk&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=3&pp=iAQB)
* [Multi-platforms Build with Remote Build Execution](https://youtube.com/watch?v=XimUovAh46k&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=4&pp=iAQB)
* [Towards Faster Cross-Platform Builds](https://youtube.com/watch?v=Et1rjb7ixUU&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=5&pp=iAQB)
* [A founder journey: from building Bazel to giving it super powers with EngFlow](https://youtube.com/watch?v=TyPYZSp4nnE&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=6&pp=iAQB)
* [Aspect Workflows](https://youtube.com/watch?v=nicNBI9T1Ow&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=7&pp=iAQB)
* [Finding and Fixing Strange Builds with BuildBuddy](https://youtube.com/watch?v=37C5zvQHnZI&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=8&pp=iAQB)
* [Reusing bazel’s analysis cache by cloning micro-VMs](https://youtube.com/watch?v=YycEXBlv7ZA&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=9&pp=iAQB)
* [Remote execution, the DIY edition](https://youtube.com/watch?v=JjZ0A1YkKsU&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=10&pp=iAQB)
* [Migrating a multiple-platform game engine to Bazel](https://youtube.com/watch?v=8pFrEuxyqxo&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=11&pp=iAQB)
* [Building a great web application development experience with Bazel](https://youtube.com/watch?v=Xs3E5SvSYg4&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=12&pp=iAQB)
* [How Uber Manages Go Dependencies with Bzlmod](https://youtube.com/watch?v=QLbkMdUOI48&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=13&pp=iAQB)
* [with_cfg: Making transitions more accessible](https://youtube.com/watch?v=U5bdQRQY-io&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=14&pp=iAQB)
* [Validation actions: correct builds off the critical path](https://youtube.com/watch?v=w691siwgynE&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=15&pp=iAQB)
* [Visualizing Build Graphs with Skyscope](https://youtube.com/watch?v=nDRPbnf0T2I&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=16&pp=iAQB)
* [Remote Output Service - How not to have your bytes and eat them too](https://youtube.com/watch?v=dVIMndTxhwc&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=17&pp=iAQB)
* [Bazel-building an iOS app containing 330+ frameworks](https://youtube.com/watch?v=1DIJU1yao_g&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=18&pp=iAQB)
* [Planting Bazel in barren soil: A Perl Story](https://youtube.com/watch?v=FFtZAKAm0qA&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=19&pp=iAQB)
* [How we build without the public internet](https://youtube.com/watch?v=XVDjqdBEX0g&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=20&pp=iAQB)
* [I'm an Imposter and So Can You: working in many languages at once](https://youtube.com/watch?v=AJpcKrF2al8&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=21&pp=iAQB)
* [A new way to manage dependencies: How we extended bzlmod](https://youtube.com/watch?v=B7GSYI8GLg8&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=22&pp=iAQB)
* [Bazel Rules](https://www.youtube.com/watch?v=i6nmR1patwY&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=24)
* [Secure your Bazel artifacts using SLSA](https://www.youtube.com/watch?v=zAjj7rNaFF4&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=40)
* [Automating Build Files](https://youtube.com/watch?v=ScB0XiFrcOE&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=24&pp=iAQB)
* [Bazel observability and remote services in a multi-build tool organization](https://youtube.com/watch?v=FdR60AAZjb8&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=25&pp=iAQB)
* [Buildbarn - Remote execution with 100 to 100,000 CPUs](https://youtube.com/watch?v=uPRcID7JHjY&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=26&pp=iAQB)
* [Bazel build analytics with ThoughtSpot](https://youtube.com/watch?v=zJ4lQ5V1daE&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=27&pp=iAQB)
* [Bringing Bazel to Windows, then and now](https://youtube.com/watch?v=7EkswBMF8W4&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=28&pp=iAQB)
* [Unlocking Bazel's Potential with Monorepo: A Key to Efficient Software Development](https://youtube.com/watch?v=T1qR5lCWLp0&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=29&pp=iAQB)
* [Building Self Driving Cars with Bazel - Part 2: Scaling](https://youtube.com/watch?v=oui9v-ZKW-Y&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=30&pp=iAQB)
* [RabbitMQ and the Story of rules_erlang](https://youtube.com/watch?v=kax1Su_WSu4&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=31&pp=iAQB)
* [JDK21 and Bazel](https://youtube.com/watch?v=MUM4MwssApY&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=32&pp=iAQB)
* [Improving CI efficiency with Bazel querying and bazel-diff](https://youtube.com/watch?v=QYAbmE_1fSo&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=33&pp=iAQB)
* [Dude, where’s my ram? An adventure in finding a ram thief in starlark land](https://youtube.com/watch?v=9isgTRWfDx8&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=34&pp=iAQB)
* [SBOMs via Bazel: Roadmap Update](https://youtube.com/watch?v=9O-pr_yhjMI&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=35&pp=iAQB)
* [Intellij IDEA & Bazel: what aspects can tell us about your project?](https://youtube.com/watch?v=4OiLZYLz3ZE&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=36&pp=iAQB)
* [Bazel-lib for BUILD and rules authors](https://youtube.com/watch?v=9eDxaAMuXBQ&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=37&pp=iAQB)
* [Python and Bazel: Aspect’s rules_py](https://youtube.com/watch?v=1GafMnbINik&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=38&pp=iAQB)
* [Kickoff: A Cross-Platform Native Launcher](https://youtube.com/watch?v=Y1e4XgDeE9E&list=PLxNYxgaZ8Rsefrwb_ySGRi_bvQejpO_Tj&index=39&pp=iAQB)

## BoF Notes

* [[BoF session] Collecting Bazel usage data responsibly](https://docs.google.com/document/d/17iZX7KadsIcK8zVtuVbp2yL0o9Z5985AU24xx-8aYA0/edit?usp=drive_link)
* [[BoF session] Android](https://docs.google.com/document/d/1wql1Iyo61FvuP6YOujMisi6t9yZZBBQZEfWzz2KGtrQ/edit?usp=drive_link)
* [[BoF session] JavaScript](https://docs.google.com/document/d/1YBsTNGnFqqN1MKW1Mfenxx8Dy2GLrMcc6NKkwoQIirE/edit?usp=drive_link)
* [[BoF session] Remote Execution](https://docs.google.com/document/d/1g1WRLDJNfxwEEsw8Ca3gGKcWHNWkNFAL_UOWt09kC6w/edit?usp=drive_link)
* [[BoF session] Authoring Bazel Rulesets](https://docs.google.com/document/d/1GzocL_tYxlnfEs4QLvLhqdV9UqV-L98uWwwILaxUllM/edit?usp=drive_link)
* [[BoF session] Bazel + IntelliJ](https://docs.google.com/document/d/1If-txtYdRVRvrRA03XVBsYqPzOBZoAQCa3HwxbTXSvc/edit?usp=drive_link)
* [[BoF session] Apple](https://docs.google.com/document/d/1V2xnA48j_wiDHqlhTwjtxK0CSX34_ya3kgoOCIlG-kc/edit?usp=drive_link)
* [[BoF session] Bzlmod](https://docs.google.com/document/d/14Iu-D9a9K9yK4giOOpcYkt7rJtvrezhDAYm8uJ6jSV8/edit?usp=drive_link)
