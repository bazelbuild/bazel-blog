---  
layout: posts
title: Migration Help: --config parsing order    
---  

`--config` expansion order is changing, in order to make it better align with user expectations, and to make layering of configs work as intended. To prepare for the change, please test your build with startup option `--expand_configs_in_place`.

Please test this change with Bazel 0.10, triggered by the startup option `--expand_configs_in_place`. The change is mostly live with Bazel 0.9, but the newest release adds an additional warning if explicit flags are overriden, which should be helpful when debugging differences. The new expansion order will become the default behavior soon, and will then no longer be configurable.

## Background: bazelrc & --config 

[The Bazel User Manual](https://docs.bazel.build/versions/master/user-manual.html#bazelrc) contains the official documentation for bazelrcs and will not be repeated here.   
A Bazel build command line generally looks something like this:

    bazel <startup options> build <command options> //some/targets

For the rest of the doc, command options are the focus. Startup options can affect which bazelrc's are loaded, and the new behavior is gated by a startup option, but the config mechanisms are only relevant to command options.

The bazelrcs allow users to set command options by default. These options can either be provided unconditionally or through a config expansion:

+  Unconditionally, they are defined for a command, and all commands that inherit from it,  
	`build --foo # applies "--foo" to build, test, etc`.
+  As a config expansions  
	`# applies "--foo" to build, test, etc. when --config=foobar is set.  
	build:foobar --foo `

## What is changing 

### The current order: fixed-point --config expansion

The current semantics of --config expansions breaks last-flag-wins expectations. In broad strokes, the current option order is

1. Unconditional rc options (options set by a command without a config, "`build --opt`")
1. All `--config` expansions are expanded in a "fixed-point" expansions.   
_This does not check where the `--config` option initially was (rc, command line, or another `--config`), and will parse a single `--config` value at most once. Use `--announce_rc` to see the order used!_
1. Command-line specified options

Bazel claims to have a last-flag-wins command line, and this is usually true, but the fixed-point expansion of configs makes it difficult to rely on ordering where `--config` options are concerned.   
See the Boolean option example below.

### The new order: Last-Flag-Wins

Everywhere else, the last mention of a single-valued option has “priority” and overrides a previous value. The same will now be true of `--config` expansion. Like other expansion options, `--config` will now expand to its rc-defined expansion “in-place,” so that the options it expands to have the same precedence. 

Since this is no longer a fixed-point expansion, there are a few other changes:

+  `--config=foo --config=foo` will be expanded twice. If this is undesirable, more care will need to be taken to avoid redundancy. Double occurences will cause a warning.
+  cycles are no longer implicitly ignored, but will error out.

Other rc ordering semantics remain. "common" options are expanded first, followed by the command hierarchy. This means that for an option added on the line "`build:foo --buildopt`", it will get added to `--config=foo`'s expansion for bazel build, test, coverage, etc. "`test:foo --testopt`" will add `--testopt` after the (less specific and therefore lower priority) build expansion of `--config=foo`. If this is confusing, avoid alternating command types in the rc file, and group them in order, general options at the top. This way, the order of the file is close to the interpretation order.

## How to start using new behavior 

1. Check your usual `--config` values’ expansions by running your usual bazel command line with `--announce_rc`. The order that the configs are listed, with the options they expand to, is the order in which they are interpreted.

1. Spend some time understanding the applicable configs, and check if any configs expand to the same option. If they do, you may need to move rc lines around to make sure the same value has priority with the new ordering.  See “Suggestions for config definers.”

1. Flip on the startup option `--expand_configs_in_place` and debug any differences using `--announce_rc` 

   _If you have a shared bazelrc for your project, note that changing it will propagate to other users who might be importing this bazelrc into a personal rc. Proceed with caution as needed_

1. Add the startup option to your bazelrc to continue using this new expansion order.

### Suggestions for config definers

You might be in a situation where you own some `--config` definitions that are shared between different people, even different teams, so it might be that the users of your config are using both `--expand_configs_in_place` behavior and the old, default behavior.

In order to minimize differences between old and new behavior, here are some tips. 

1. Avoid internal conflicts within a config expansion (redefinitions of the same option)
1. Define recursive `--config` at the END of the config expansion
   - Only critical if #1 can’t be followed.

#1 is especially important if the config expands to another config. The behavior will be more predictable with `--expand_configs_in_place`, but without it, the expansion of a single `--config` depends on previous `--configs`. 

#2 helps mitigate differences if #1 is violated, since the fixed-point expansion will expand all explicit options, and then expand any newly-found config values that were mentioned in the original config expansions. This is equivalent to expanding it at the end of the list, so use this order if you wish to preserve old behavior. 

#### Motivating examples

The following example violates both #1 and #2, to help motivate why #2 makes things slightly better when #1 is impossible.
```
bazelrc contents:
	build:foo --cpu=x86
	build:misalteredfoo --config=foo # Violation of #2!
	build:misalteredfoo --cpu=arm64 # Violation of #1!
```

- `bazel build --config=misalteredfoo`

   effectively x86 in fixed-point expansion, and arm64 with in-place expansion


The following example still violates #1, but follows suggestion #2:
```
bazelrc contents:
	build:foo --cpu=x86
	build:misalteredfoo --cpu=arm64 # Violation of #1!
	build:misalteredfoo --config=foo
```

- `bazel build --config=misalteredfoo`

   effectively x86 in both expansions, so this does not diverge and appears fine at first glance. (thanks, suggestion #2!)

- `bazel build --config=foo --config=misalteredfoo`

   effectively arm64 in fixed-point expansion, x86 with in-place, since misalteredfoo’s expansion is independent of the previous config mention. 

### Suggestions for users of `--config`

Lay users of `--config` might also see some surprising changes depending on usage patterns. The following suggestions are to avoid those differences. Both of the following will cause warnings if missed.

A. Avoid including to the same `--config` twice

B. Put `--config` options FIRST, so that explicit options continue to have precedence over the expansions of the configs.

Multiple mentions of a single `--config`, when combined with violations of #1, may cause surprising results, as shown in #1’s motivating examples. In the new expansion, multiple expansions of the same config will warn. Multi-valued options will receive duplicates values, which may be surprising. 

#### Motivating example for B

```
bazelrc contents:
	build:foo --cpu=x86

```

- `bazel build --config=foo --cpu=arm64 # Fine`

   effectively arm64 in both expansion cases

- `bazel build --cpu=arm64 --config=foo # Violates B`

   The explicit value arm64 has precedence with fixed-point expansion, but the config value x86 wins in in-place expansion. With in-place expansion, this will print a warning.

## Additional Boolean Option Example

There are 2 boolean options, `--foo` and `--bar`. Each only accept one value (as opposed to accumulating multiple values).   

In the following examples, the two options `--foo` and `--bar` have the same apparent order (and will have the same behavior with the new expansion logic). What changes from one example to the next is where the options are specified.

<table>
<thead>
<tr>
<th><strong>bazelrc</strong></th>
<th><strong>Command Line</strong></th>
<th><strong>Current final value</strong></th>
<th><strong>New final value</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td><p><pre>
<empty>
</pre></p>

</td>
<td><p><pre>
--nofoo 
--foo
--bar 
--nobar 
</pre></p>

</td>
<td><p><pre>
--foo 
--nobar
</pre></p>

</td>
<td><p><pre>
--foo 
--nobar
</pre></p>

</td>
</tr>
<tr>
<td><p><pre>
# Config definitions 
build:all --foo
build:all --bar
</pre></p>

</td>
<td><p><pre>
--nofoo 
--config=all 
--nobar 
</pre></p>

</td>
<td><p><pre>
--nofoo
--nobar
</pre></p>

</td>
<td><p><pre>
--foo 
--nobar
</pre></p>

</td>
</tr>
<tr>
<td><p><pre>
# Set for every build
build --nofoo
build --config=all
build --nobar
<br>
# Config definitions 
build:all --foo
build:all --bar
</pre></p>

</td>
<td><p><pre>
<empty>
</pre></p>

</td>
<td><p><pre>
--foo
--bar
</pre></p>

</td>
<td><p><pre>
--foo 
--nobar
</pre></p>

</td>
</tr>
</tbody>
</table>

Now to make this more complicated, what if a config includes another config? 

<table>
<tr>
<th><strong>bazelrc</strong></th>
<th><strong>Command Line</strong></th>
<th><strong>Current final value</strong></th>
<th><strong>New final value</strong></th>
</tr>
<tr>
<td rowspan="2">
<p><pre>
# Config definitions 
build:combo --nofoo
build:combo --config=all
build:combo --nobar
build:all --foo
build:all --bar
</pre></p>
</td>
<td>
<p><pre>
--config=combo 
</pre></p>
</td>
<td>
<p><pre>
--foo 
--bar
</pre></p>
</td>
<td>
<p><pre>
--foo 
--nobar
</pre></p>
</td>
</tr>
<tr><!-- 
<td></td> -->
<td>
<p><pre>
--config=all
--config=combo 
</pre></p>
</td>
<td>
<p><pre>
--nofoo
--nobar
</pre></p>
</td>
<td>
<p><pre>
--foo 
--nobar
</pre></p>
</td>
</tr>	
</table>

Here, counterintuitively, including `--config=all` explicitly makes its values effectively disappear. This is why it is basically impossible to create an automatic migration script to run on your rc - there's no real way to know what the _intended_ behavior is.  

Unfortunately, it gets worse, especially if you have the same config for different commands, such as build and test, or if you defined these in different files. It frankly isn't worth going into the further detail of the ordering semantics as it's existed up until now, this should suffice to demonstrate why it needs to change.  

To understand the order of your configs specifically, run Bazel as you normally would (remove targets for speed) with the option `--announce_rc`. The order in which the config expansions are output to the terminal is the order in which they are currently interpreted (again, between rc and command line). 


*By [Chloe Calvarin](https://github.com/cvcal)*
