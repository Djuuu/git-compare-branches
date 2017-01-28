# git-compare-branches

This script compares two branches by showing which other branches are specifically merged into each one.

## Installation

* Clone The repository

Then : 
* Create a symlink to the script in a directory in your path
```bash
ln -s /path/to/git-compare-branches/git-compare-branches.sh ~/bin/git-compare-branches
```

OR

* Create a git alias in your `.gitconfig`
```ini
[alias]
    compare-branches = "!bash /path/to/git-compare-branches/git-compare-branches.sh"
```

## Usage

```bash
git compare-branches toto tata
```
```
Branches merged only in toto :

  azer
  remotes/origin/ytui
  remotes/origin/op

Branches merged only in tata :

  qsdf
  ghjk
  remotes/origin/lm
```
