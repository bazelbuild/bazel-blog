---
layout: posts
title: "Exploring the IntelliJ Bazel Plugin's Sync Process"
authors:
  - jin
---

In this blogpost, we aim to understand IntelliJ with Bazel plugin's sync process
through exploring the plugin's generated files.

## Introduction

The sync process is central to the user experience of working with Bazel using
the [IntelliJ plugin](https://ij.bazel.build). The purpose of the sync process
is to query Bazel for information and build up IntelliJ's project structure to
fit Bazel's model. It runs automatically during a project import, and manually
by either clicking on the sync icon in the menu bar or, partially syncing
packages and individual files in contextual menus.

Running a sync generates a `.ijwb` directory in the project root. While users
don’t typically need to know about the contents of this directory, exploring
these files help us understand how the plugin works.

Next, we explore the sync process' logs and understand what is happening
behind the scenes.

Finally, we connect the dots between the logs and the generated files to
crystalize our understanding.

Let's dive in!

## Structure of `.ijwb`

Using a [Spring Boot project
example](https://github.com/bazelbuild/rules_jvm_external/tree/master/examples/spring_boot),
[BlazeSyncManager](https://github.com/bazelbuild/intellij/blob/master/base/src/com/google/idea/blaze/base/sync/BlazeSyncManager.java)
generates this directory on a project sync.

```
$ tree -a .ijwb/
.ijwb/
├── .bazelproject
├── .blaze
│   ├── libraries
│   ├── modules
│   │   ├── .project-data-dir.iml
│   │   └── .workspace.iml
│   └── remoteOutputCache
└── .idea
    ├── .name
    ├── codeStyles
    │   └── codeStyleConfig.xml
    ├── externalDependencies.xml
    ├── libraries
    │   ├── Runner_deploy_ijar_d8363141.xml
    │   ├── hamcrest_library_1_3_c425095b.xml
    │   ├── spring_beans_5_1_5_RELEASE_c7c017d3.xml
    │   ├── spring_boot_2_1_3_RELEASE_f01f6f60.xml
    │   ├── spring_boot_autoconfigure_2_1_3_RELEASE_77fee7ea.xml
    │   ├── spring_boot_starter_web_2_1_3_RELEASE_968a1469.xml
    │   ├── spring_boot_test_2_1_3_RELEASE_1631a67.xml
    │   ├── spring_boot_test_autoconfigure_2_1_3_RELEASE_9cfb3ab1.xml
    │   ├── spring_context_5_1_5_RELEASE_69b9cfff.xml
    │   ├── spring_core_5_1_5_RELEASE_b1cbb181.xml
    │   ├── spring_test_5_1_5_RELEASE_be462134.xml
    │   └── spring_web_5_1_5_RELEASE_90feac64.xml
    ├── misc.xml
    ├── modules.xml
    ├── runConfigurations.xml
    ├── vcs.xml
    └── workspace.xml
```

Let's investigate the components of this directory individually.

## Project view file

```
$ tree -a
.
├── .bazelproject 
```

This is the IJwB [project view file
](https://ij.bazel.build/docs/project-views.html) containing project-wide
settings, like targets to sync, Bazel flags, and enabled languages. Check this
file into your project's version control to share Bazel project settings. For
example, the basic project view file looks like this:

```
directories:
  # Add the directories you want added as source here
  # By default, we've added your entire workspace ('.')
  .

# Automatically includes all relevant targets under the 'directories' above
derive_targets_from_directories: true

targets:
  # If source code isn't resolving, add additional targets that compile it here

additional_languages:
  # Uncomment any additional languages you want supported
  # android
  # dart
  # kotlin
  # python
  # scala
```

## Bazel data subdirectory

`.ijwb/.blaze` is the Bazel data subdirectory, containing mostly IntelliJ module
definitions.

Note that the actual persistent serialized data is not in this directory. To
locate the serialized data, read the [IntelliJ
documentation](https://intellij-support.jetbrains.com/hc/en-us/articles/206544519-Directories-used-by-the-IDE-to-store-settings-caches-plugins-and-logs)
to find the OS-specific directory.

```
├── .blaze 
│   ├── libraries
```

This is the location of the plugin's JAR cache. This helps provide a more robust
code navigation experience, but with the possibility of missing changes made by
Bazel outside of the IDE view.

```
│   ├── modules 
```

This directory contains [IntelliJ
module](https://www.jetbrains.org/intellij/sdk/docs/basics/project_structure.html#module)
definition files.

```
│   │   ├── .project-data-dir.iml 
```

A module that includes just the user's data directory. This enables editing the
project view without IntelliJ complaining it's outside the project.

```
│   │   └── .workspace.iml
```

Monolithic module for the Bazel workspace.

```
│   └── remoteOutputCache
```

A general-purpose local cache for output artifacts generated remotely. During project sync, updated outputs of interest will be copied locally.

Cache files here have a hash appended to their name to allow matching to the original artifact.

## IntelliJ configuration subdirectory

`.ijwb/.idea` contains project-specific settings files managed by IntelliJ.
IntelliJ reads XML files in this directory to set up the [Project
Structure](https://www.jetbrains.org/intellij/sdk/docs/basics/project_structure.html):
project, modules, libraries, SDKs, facets.


```
└── .idea
    ├── .name
```

Name of the project.

```
    ├── codeStyles
    │   └── codeStyleConfig.xml
```

Settings for [code styles](https://www.jetbrains.com/help/idea/configuring-code-style.html).

```
    ├── externalDependencies.xml
```

Settings for external dependencies of this project. In particular, every Bazel
IntelliJ project depends on the Bazel plugin:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ExternalDependencies">
    <plugin id="com.google.idea.bazel.ijwb" />
  </component>
</project>
```

```
    ├── libraries
```

Settings for external libraries. Note that this is not the same as Bazel's concept of external repositories.

```
    │   ├── Runner_deploy_ijar_d8363141.xml
    │   ├── hamcrest_library_1_3_922bb0fc.xml
    │   ├── spring_beans_5_1_5_RELEASE_2e7c9dd2.xml
    │   ├── spring_boot_2_1_3_RELEASE_f91adddf.xml
    │   ├── spring_boot_autoconfigure_2_1_3_RELEASE_893b8c29.xml
    │   ├── spring_boot_starter_web_2_1_3_RELEASE_9ed0bc68.xml
    │   ├── spring_boot_test_2_1_3_RELEASE_eb13e348.xml
    │   ├── spring_boot_test_autoconfigure_2_1_3_RELEASE_378665d2.xml
    │   ├── spring_context_5_1_5_RELEASE_136cd23e.xml
    │   ├── spring_core_5_1_5_RELEASE_2076efa2.xml
    │   ├── spring_test_5_1_5_RELEASE_2cf15f55.xml
    │   └── spring_web_5_1_5_RELEASE_9cd2a623.xml
```

In this example, each XML file maps to a single JAR file. Most of them are
downloaded through
[`rules_jvm_external`](https://github.com/bazelbuild/rules_jvm_external/tree/master/examples/spring_boot)
into an external repository named `@maven`. For example,
`.ijwb/.idea/libraries/hamcrest_library_1_3_922bb0fc.xml` contains:

```xml
<component name="libraryTable">
  <library name="hamcrest-library-1.3_922bb0fc">
    <CLASSES>
      <root url="jar:///private/var/tmp/_bazel_jingwen/fb23c64ab599b03c55afa6d9c154aecf/execroot/__main__/bazel-out/darwin-fastbuild/bin/external/maven/v1/https/jcenter.bintray.com/org/hamcrest/hamcrest-library/1.3/hamcrest-library-1.3.jar!/" />
    </CLASSES>
    <JAVADOC />
    <SOURCES />
  </library>
</component>
```

```
    ├── misc.xml
```

Miscelleanous configuration.

```
    ├── modules.xml
```

Configuration for project modules. In the previous section, we saw that the
plugin generated two modules for project data and the workspace itself. We can
see their `.iml` files referenced in this file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ProjectModuleManager">
    <modules>
      <module fileurl="file://$PROJECT_DIR$/.blaze/modules/.project-data-dir.iml" filepath="$PROJECT_DIR$/.blaze/modules/.project-data-dir.iml" />
      <module fileurl="file://$PROJECT_DIR$/.blaze/modules/.workspace.iml" filepath="$PROJECT_DIR$/.blaze/modules/.workspace.iml" />
    </modules>
  </component>
</project>
```

```
    ├── runConfigurations.xml
```

Settings for [run configurations](https://www.jetbrains.com/help/rider/Run_Debug_Configurations_dialog.html).

```
    ├── vcs.xml
```

Settings for version control.

```
    └── workspace.xml
```

This file contains the last known persistent state of the user's workflow in the IntelliJ application.
Using these settings, IntelliJ can recreate the active tabs, settings, recently
used run configurations, and VCS tab states after restarting the IDE.

## Portability of the `.ijwb` directory

The `.ijwb` directory is not completely portable. Files like `.bazelproject` and
`codeStyleConfig.xml` can be shared project-wide, but `workspace.xml` and
`.workspace.iml` should be user specific.

In general, extract `.bazelproject` file out of `.ijwb/` to version control it,
and follow [JetBrains' recommendations
](https://intellij-support.jetbrains.com/hc/en-us/articles/206544839) on
checking in specific files in the `.idea` directory.

## Plugin cache

There are more plugin-specific cached state in the [IDE installation
directory](https://intellij-support.jetbrains.com/hc/en-us/articles/206544519-Directories-used-by-the-IDE-to-store-settings-caches-plugins-and-logs).
On macOS, this is the `~/Library/Caches/IdeaIC2019.2/blaze/projects` directory.

```
$ tree
.
└── projects
```

This is the global project persistent data and configuration cache directory.

For every project opened with the plugin using this installation, there is an
entry named after the project and the first 8 characters of a random UUID. The
UUID is used to uniquely identify the project location.

```
    └── springboot-94bce85a
        ├── cache.dat.gz
```

This is the `gzip` of the serialized
[`BlazeProjectData`](https://github.com/bazelbuild/intellij/blob/master/proto/project_data.proto)
protocol buffer. This is written to disk on sync, and read when reopening
projects.

```protobuf
message BlazeProjectData {
  reserved 1;
  TargetMap target_map = 2 [deprecated = true];
  BlazeInfo blaze_info = 3;
  BlazeVersionData blaze_version_data = 4;
  WorkspacePathResolver workspace_path_resolver = 5;
  WorkspaceLanguageSettings workspace_language_settings = 6;
  SyncState sync_state = 7;
  TargetData target_data = 8;
}
```

Most of the language specific data are in `TargetData`'s `TargetIdeInfo`,
defined in
[`intellij_ide_info.proto`](https://github.com/bazelbuild/intellij/blob/master/proto/intellij_ide_info.proto).
This is where the
[aspect](https://blog.bazel.build/2016/06/10/ide-support.html)-generated
`intellij-info.txt` files come into play:

```protobuf
message TargetIdeInfo {
  string kind_string = 1;
  TargetKey key = 2;
  ArtifactLocation build_file_artifact_location = 3;
  repeated Dependency deps = 4;
  repeated string tags = 5;
  repeated string features = 6;
  TestInfo test_info = 7;

  // The time this target was most recently synced, in milliseconds since epoch.
  // Not provided by the aspect directly; instead filled in by the plugin during
  // sync.
  int64 sync_time_millis = 20;

  JavaIdeInfo java_ide_info = 100;
  JavaToolchainIdeInfo java_toolchain_ide_info = 101;

  AndroidIdeInfo android_ide_info = 110;
  AndroidAarIdeInfo android_aar_ide_info = 111;
  AndroidSdkIdeInfo android_sdk_ide_info = 112;
  AndroidInstrumentationInfo android_instrumentation_info = 113;

  CIdeInfo c_ide_info = 120;
  CToolchainIdeInfo c_toolchain_ide_info = 121;

  PyIdeInfo py_ide_info = 130;
  GoIdeInfo go_ide_info = 140;
  JsIdeInfo js_ide_info = 150;
  TsIdeInfo ts_ide_info = 160;
  DartIdeInfo dart_ide_info = 170;
  KotlinToolchainIdeInfo kt_toolchain_ide_info = 180;
}
```

`TargetIdeInfo` is heart of the plugin's multi-language support. During a sync,
each Bazel target is associated with an `intellij-info.txt` file that contains a
text representation of the `TargetIdeInfo` proto. Here's an example for the main
Spring Boot `java_binary` target:

```json
build_file_artifact_location {
  is_external: false
  is_new_external_version: true
  is_source: true
  relative_path: "src/main/java/hello/BUILD.bazel"
  root_execution_path_fragment: ""
}
deps {
  dependency_type: 0
  target {
    label: "@local_config_cc//:toolchain"
  }
}
deps {
  dependency_type: 0
  target {
    label: "@bazel_tools//tools/jdk:current_java_toolchain"
  }
}
deps {
  dependency_type: 1
  target {
    label: "//src/main/java/hello:lib"
  }
}
java_ide_info {
  jars {
    jar {
      is_external: false
      is_new_external_version: true
      is_source: false
      relative_path: "src/main/java/hello/app.jar"
      root_execution_path_fragment: "bazel-out/darwin-fastbuild/bin"
    }
    source_jar {
      is_external: false
      is_new_external_version: true
      is_source: false
      relative_path: "src/main/java/hello/app-src.jar"
      root_execution_path_fragment: "bazel-out/darwin-fastbuild/bin"
    }
    source_jars {
      is_external: false
      is_new_external_version: true
      is_source: false
      relative_path: "src/main/java/hello/app-src.jar"
      root_execution_path_fragment: "bazel-out/darwin-fastbuild/bin"
    }
  }
  main_class: "hello.Application"
}
key {
  label: "//src/main/java/hello:app"
}
kind_string: "java_binary"
```

This file contains all language-specific information IntelliJ needs to know
about the target, which can be used to integrate with language plugins directly.
It enables features such as semantic code browsing, autocomplete, refactoring,
reference finding and go-to-definition.

```
        └── project.view.dat
```

Finally, this is the serialized form of the Bazel project view. This prevents
the need for parsing the `.bazelproject` project view file every time we open
the project.

## Connecting the dots

Now that we understand what the generated files are and what they're for, we can
explore the sync process' timeline through logs. Here's a simplified form of
what you'd see in the Bazel Console during a sync:

```
Syncing project: Sync (incremental)...

< ... >

Building Bazel targets...
Command: bazel build \
  --aspects=@intellij_aspect//:intellij_info_bundled.bzl%intellij_info_aspect \
  --output_groups=intellij-info-generic,intellij-info-java,intellij-resolve-java \
  <other flags> \
  //src/main/java/hello:app
```

Here, the plugin invokes Bazel to apply the [plugin
aspect](https://github.com/bazelbuild/intellij/tree/master/aspect) over the
transitive closure of the specified Bazel targets in the project view file.

The [output
groups](https://docs.bazel.build/versions/master/skylark/rules.html#requesting-output-files)
determine the set of requested files. In this Java project, the plugin requests
for the `intellij-info-java` and `intellij-resolve-java` output groups by
default, which instructs Bazel to run the actions that produces the respective
`intellij-info.txt` and JAR files for the project view's targets. This builds up
the `TargetData` and `BlazeProjectData` structures, which the plugin serializes
onto the disk for persistence.

After the build completes, the plugin processes the earlier outputs to generate
the internal project model, writes the necessary IDE metadata files, and commits
the project structure:

```
Loading: 0 packages loaded
Analyzing: 4 targets (2 packages loaded, 123 targets configured)

<...>

INFO: Build completed successfully, 49 total actions

<...>

Parsing build outputs...
Total rules: 48, new/changed: 42, removed: 0
Reading IDE info result...

Updating target map
Loaded 42 aspect files, total size 77kB
Target map size: 48

<...>

Reading package manifests...

Updating Jar Cache...
Prefetching files...
Refreshing files
Computing directory structure...
Committing project structure...
Workspace has 12 libraries
Workspace has 2 modules
Updating in-memory state...

Sync finished
```

With this, the sync process completes and the project is ready for development in IntelliJ.
