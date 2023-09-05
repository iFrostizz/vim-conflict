# conflict.vim

Open all git conflicting files in buffers !

## Why

This plugin should be ran in a git repo with conflicting files.
Multiple solutions already exists such as:

1. grep for any "<<<<<< HEAD" in files (boring)
2. git diff --name-only (time consuming)
3. git diff --check (verbose)

But none to open all of the conflicting files directly from vim / nvim !

## How

Just run the command `:Conflicts` and the script is going to open all conflicting files in buffers.

It will scan for all unique files returned by `git diff --name-only` and filter out for only files containing the conflict marks (<<<<<< HEAD)

## Demo

![Demo](./vim-conflict.gif)
