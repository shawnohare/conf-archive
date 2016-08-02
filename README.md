# Shawn O'Hare's Dotfiles

# Introduction

These dotfiles are organized to take advantage of the GNU `stow` symlink
farm manager.  For example, executing `stow git` from the dotfiles root
directory will symlink the version controlled git configuration files to
the correct location.  

Dotfiles are generally organized topically.

# Installation

```bash
curl https://raw.githubusercontent.com/shawnohare/dotfiles/master/bin/bin/conf.sh | bash -s install
```

## conf.sh helper script

The conf script in the `bin` dir provides a number of commands to ease
bootstrap and configuration maintenance.

# Manual steps

1. On macOS, install the xcode command line tools: `xcode-select --install`
1. Get pyenv: `curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash`
1. Get `git` (`xcode-select --install` for macos or `sudo apt-get git` on ec2 linux)
1. Get `stow` (`brew install stow` or potentially build from source on macos)
1. Get dotfiles repo.
1. `Run ~/dotfiles/bin/bin/conf init (or install)`

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
