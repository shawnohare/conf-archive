# Shawn O'Hare's Dotfiles

# Introduction

These dotfiles are organized to take advantage of symlink
farm manager system similar to GNU `stow`.

In order to maintain a measure of robustness to change, some steps that could
be automated are specifically made manual. 

Dotfiles are generally organized topically.

# Installation

# Manual steps

1. On macOS, install the xcode command line tools: `xcode-select --install`
1. Get pyenv: `curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash`
1. Get `git` (`xcode-select --install` for macos or `sudo apt-get -y git` on ec2 linux)
1. Get `stow` (`brew install stow` or potentially build from source on macos)
1. Get dotfiles repo.
1. `Run ~/dotfiles/bin/bin/conf init (or install)`

## Initialization

Some manual commands should be run first.

### macOS

- `xcode-select --install` : to install developer command line tools.

### Linux

- Install `curl`.  For example, `sudo apt-get -y install curl` on
  Debian and Ubuntu.

## Script

```bash
curl https://raw.githubusercontent.com/shawnohare/dotfiles/master/install | bash
```

## dotfiles helper script

The `dotfiles` script in the `bin` dir provides a number of commands to ease
bootstrap and configuration maintenance.


## Clonig

To clone this repository along with its submodule dependencies, use
```bash
git clone --recursive https://github.com/shawnohare/dotfiles.git
```

# Configuration

## profile

The `profile` dir contains common shell exports, aliases, and etc. that make
up our shell profile. It is sourced by `~.bash_profile`, `~.bashrc`, and
`~/.zshenv`

## Git 

These files live in `${XDG_CONFIG_HOME}/git` and represent the global
user configuration settings.  Local or private settings go in the
`config.local` file, which is loaded by the `config` file.
