# Shawn O'Hare's Dotfiles

# Introduction

These dotfiles are organized to take advantage of symlink
farm manager system similar to GNU `stow`.

In order to maintain a measure of robustness to change, some steps that could
be automated are specifically made manual. 

Dotfiles are generally organized topically.

# Installation

1. Install `curl` and `git`.  This can be done with
```bash
xcode-select --install # macos
sudo apt-get install -y curl git # debian / ubuntu
```

1. `curl` the basic install script.
```bash
curl https://raw.githubusercontent.com/shawnohare/dotfiles/master/install | bash
```

# dotfiles helper script

The `dotfiles` script in the `bin` dir provides a number of commands to ease
configuration maintenance.


# Configuration

## profile

The `profile` dir contains common shell exports, aliases, and etc. that make
up our shell profile. It is sourced by `~.bash_profile`, `~.bashrc`, and
`~/.zshenv`

## Git

These files live in `${XDG_CONFIG_HOME}/git` and represent the global
user configuration settings.  Local or private settings go in the
`config.local` file, which is loaded by the `config` file.
