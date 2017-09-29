## GIT Remote Branch Housekeeping

[![Build Status](https://travis-ci.org/hyperia-sk/remote-branch-housekeeping.svg?branch=master)](https://travis-ci.org/hyperia-sk/remote-branch-housekeeping) [![codecov](https://codecov.io/gh/hyperia-sk/remote-branch-housekeeping/branch/master/graph/badge.svg)](https://codecov.io/gh/hyperia-sk/remote-branch-housekeeping)

> `git remote-branch-housekeeping` is a simple and efficient way to delete remote (`--merged` or `--no-merged`) branches from git repository.

![screenshot](https://user-images.githubusercontent.com/6382002/28468955-f327d632-6e34-11e7-8848-753c94dbc644.png)

## Usage

```bash
git remote-branch-housekeeping
# or 
remote-branch-housekeeping
```

#### Parameters
```
remote-branch-housekeeping [ -f | -r | -d | -b | -n ]

-d <number>, --days <number>
Defines days, default 14.

-b <master>, --branch <master>
Branch name, default "master".

-r <origin>, --remote <origin>
Remote name, default "origin".

-n, --no-merged
Delete only branches that are not merged.

-f, --force
Don't ask for confirm to delete branches.
```

## Installation

```bash
git clone https://github.com/hyperia-sk/remote-branch-housekeeping.git && cd remote-branch-housekeeping
```

Open up the cloned directory and run:

#### Unix like OS

```bash
sudo make install
```

For uninstalling

```bash
sudo make uninstall
```

For update/reinstall

```bash
sudo make reinstall
```

#### OS X (homebrew)

@todo

#### Windows (cygwin)

```bash
C:\cygwin\bin\bash installer.sh
```

For uninstalling

```bash
C:\cygwin\bin\bash uninstaller.sh
```


## System requirements

* Unix like OS with a proper shell
* Tools we use: git ; perl ; grep ; sort ; sed ; head ; wc ; xargs ; date


#### Dependences

* [`perl`](https://www.perl.org/get.html) `apt install perl`


## Contribution 

Want to contribute? Great! First, read this page.

#### Code reviews

All submissions, including submissions by project members, require review. 
We use Github pull requests for this purpose.

#### Some tips for good pull requests:
* Use our code
  When in doubt, try to stay true to the existing code of the project.
* Write a descriptive commit message. What problem are you solving and what
  are the consequences? Where and what did you test? Some good tips:
  [here](http://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
  and [here](https://www.kernel.org/doc/Documentation/SubmittingPatches).
* If your PR consists of multiple commits which are successive improvements /
  fixes to your first commit, consider squashing them into a single commit
  (`git rebase -i`) such that your PR is a single commit on top of the current
  HEAD. This make reviewing the code so much easier, and our history more
  readable.

#### Formatting

This documentation is written using standard [markdown syntax](https://help.github.com/articles/markdown-basics/). Please submit your changes using the same syntax.

#### Tests

```bash
make test
```

## Licensing
MIT see [LICENSE][] for the full license text.

   [read this page]: https://github.com/hyperia-sk/remote-branch-housekeeping/blob/master/CONTRIBUTING.md
   [landing page]: https://github.com/hyperia-sk/remote-branch-housekeeping
   [LICENSE]: https://github.com/hyperia-sk/remote-branch-housekeeping/blob/master/LICENSE
