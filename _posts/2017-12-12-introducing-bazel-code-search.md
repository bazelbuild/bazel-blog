---
layout: posts
title: Introducing Bazel Code Search
---

We are always looking for new ways to improve the experience of contributing to Bazel and helping users understanding how Bazel works. Today, we’re excited to share a preview of [Bazel Code Search](https://source.bazel.build), a major upgrade to Bazel’s code search site. This new site features a [refreshed user interface for code browsing](#browsing-through-bazel-repositories) and cross-repository [semantic search](#searching-the-bazel-codebase) with regular expression support, and a [navigable semantic index](#understanding-the-bazel-codebase-using-cross-references) of all definitions and references for the Bazel codebase. We’ve also updated the “Contribute” page on the Bazel website with [documentation for this tool](https://bazel.build/browse-and-search-user-guide.html). 

# Getting started with Bazel Code Search 
You can try Bazel Code Search right now by visiting [https://source.bazel.build](https://source.bazel.build). 

Select the repository you want to browse from the list on the main screen, or search across all Bazel repositories on the site using the search box at the top of the page. 

![Main screen of Bazel Code Search](/assets/bazel-code-search-main-screen.png)

<a id="searching-the-bazel-codebase"></a> 
## Searching the Bazel codebase
Bazel Code Search has a semantic understanding of the Bazel codebase and allows you to [search for either files or code within files](https://bazel.build/browse-and-search-user-guide.html#search). This semantic understanding of the code means that the search index identifies which parts of your code are entities such as classes, functions, and fields.  Since the search index has classified these entities, your queries can include filters to [scope the search to classes or functions](https://bazel.build/browse-and-search-user-guide.html#search) and allows for improved search relevance by ranking important parts of code like classes, functions, and fields higher. By default, all searches use [RE2 regular expressions](https://github.com/google/re2/wiki/Syntax) though you can escape individual special characters with a backslash, or an entire string by enclosing it in quotes. 

To search, start typing in the search box at the top of the screen and you’ll see suggestions for matching results. For Java, JavaScript, and Proto, result suggestions indicate if the match is an entity such as a Class, Method, Enum or Field. Semantic understanding for more languages is on the way. 

![Bazel code search suggestions](/assets/bazel-code-search-suggestions.png)

If you don’t see the result you want in the suggestions, you can submit your search and find all matches on the search result page. From the results page, you can select a matching line or file to view. 

Here’s a sampling of different search examples to try out on your own: 
* [ccToolchain](https://source.bazel.build/search?q=ccToolchain)
    * search for the substring “ccToolchain”
* [class ccToolchain](https://source.bazel.build/search?q=class%20ccToolchain)
    * search for files containing both “class” and “ccToolchain” substrings
* [“class ccToolchain”](https://source.bazel.build/search?q="class%20ccToolchain")
    * search for files containing the phrase “class ccToolchain” 
* [class:ccToolchain](https://source.bazel.build/search?q=class:ccToolchain)
    * search for classes where the name of a class contains the substring “ccToolchain”
* [file:cpp ccToolchain](https://source.bazel.build/search?q=file:cpp%20ccToolchain)
    * search for files containing the substring “ccToolchain” where “cpp” is in the file path 
* [file:cpp lang:java ccToolchain](https://source.bazel.build/search?q=file:cpp%20lang:java%20ccToolchain)
    * search for Java files containing the substring “ccToolchain” where “cpp” is in the file path
* [aggre.*test](https://source.bazel.build/search?q=aggre.*test)
    * search for the regular expression “aggre.*test”
* [ccToolchain -test](https://source.bazel.build/search?q=ccToolchain%20-test)
    * search for the substring “ccToolchain” excluding any files containing the substring “test”
* [cTool case:yes](https://source.bazel.build/search?q=cTool%20case:yes)
    * search for the substring “cTool” (case sensitive)

Note that all searches are case insensitive unless you specify “case:yes” in the query. 

<a id="understanding-the-bazel-codebase-using-cross-references"></a> 
## Understanding the Bazel codebase using cross references
Another way to understand the Bazel repository is through the use of [cross references](https://bazel.build/browse-and-search-user-guide.html#browsing-cross-references). If you’ve ever wondered how to properly use a method, cross references can help by displaying all references to that method so you can see how it is used in other parts of the codebase. Alternatively, if you see a method being used but don’t understand what that method actually does, cross references enables you to click the method to view the definition or see how it’s used elsewhere. 

![Cross refereneces pane](/assets/bazel-code-search-xref-pane.png)

Cross references aren’t only available for methods, they’re also generated for classes, fields, imports, and enums. Bazel Code Search uses the [Kythe](https://kythe.io/docs/kythe-overview.html) open source project to generate a semantic index of cross references for the Bazel codebase. These cross references appear automatically as hyperlinks within source files. To make cross references easier to identify, click the **Cross References** button to underline all cross references in a file. 

![Cross references underlined](/assets/bazel-code-search-xref-underlined.png)

Once you’ve clicked on a cross reference, the cross references pane will be displayed where you can view all the definitions and references organized by file. Within the cross references pane, you can navigate into multiple levels of depth of cross references while continuing to view the original file you were viewing in the File pane allowing you to maintain context of the original task. 

![Navigating through levels of cross references](/assets/bazel-code-search-xref-levels.png)

<a id="browsing-through-bazel-repositories"></a> 
## Browsing through Bazel repositories
Selecting a repository from the main screen will take you to a view of the chosen repository with search scoped to its contents. The breadcrumb toolbar at the top allows you to quickly navigate to other [repositories](https://bazel.build/browse-and-search-user-guide.html#switch-repositories), [refs](https://bazel.build/browse-and-search-user-guide.html#open-a-branch-commit-or-tag), or folders. 

![Repository view on Bazel Code Search](/assets/bazel-code-search-repo-view.png)

From the view of the repository, you can browse through folders and files in the repository while taking advantage of [blame](https://bazel.build/browse-and-search-user-guide.html#view-file-changes), [change history](https://bazel.build/browse-and-search-user-guide.html#view-change-history), a [diff view](https://bazel.build/browse-and-search-user-guide.html#compare-a-file-to-a-different-commit) and many other features. 

![Bazel Code Search File View showing Blame and History](/assets/bazel-code-search-file-view.png)

# Give Feedback 
We hope you’ll try [Bazel Code Search](https://source.bazel.build) and provide feedback through the “**!**” button in the top right of any page on the Bazel Code Search site. We would love to hear whether this tool helps you work with Bazel and what else you’d like to see Bazel Code Search offer. 

Keep in mind that this project is still experimental and is subject to change.

*By [Russell Wolf](https://github.com/russwolf)*
