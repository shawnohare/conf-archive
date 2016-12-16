# Shawn O'Hare's config files

# Introduction

These config files are organized to take advantage of symlink
farm manager system similar to GNU `stow`.  Where possible, we prefer
to follow the XDG conventions for configuration files, as an increasing
number of applications we use take advantage of this specification. 

In order to maintain a measure of robustness to change, some steps that could
be automated are specifically made manual. It is our experience that
automatation maintenance costs increase hyper-linearly with volatility.

config files are generally organized topically.

# Installation

Some manual initialization leads to less headaches.

Install `curl`, `git`, and `bzip`.  This can be done with
```bash
xcode-select --install # macos
```
On Linux (Debian based systems) 

```bash
sudo apt-get update
sudo apt-get -y upgrade 
sudo apt-get install -y curl git bzip # debian / ubuntu
```

1. `curl` the basic install script.
```bash
curl https://raw.githubusercontent.com/shawnohare/config files/master/install | bash
```

# config files helper script

The `config files` script in the `bin` dir provides a number of commands to ease
configuration maintenance.

# Manual Steps

- Installing the basic initialzation tools mentioned above: `xcode` command
  line tools, `curl`, and `git`.
- Tell `iterm` to look in `~/config files/iterm/.config/iterm` for its config.
- Download `iterm` for macOS and install the associated shell integration
  script via iterm.  ~~Move the integration script to `${XDG_CONFIG_HOME}/iterm2`.~~
  It seems that moving the shell integration script causes iterm to always
  think the script is out of date.
- Delete the spurious `~/.zshrc` file created by the iterm shell integration install.

# Configuration

## profile

The `profile` dir contains common shell exports, aliases, and etc. that make
up our shell profile. It is sourced by `~.bash_profile`, `~.bashrc`, and
`~/.zshenv`

## Git

These files live in `${XDG_CONFIG_HOME}/git` and represent the global
user configuration settings.  Local or private settings go in the
`config.local` file, which is loaded by the `config` file.
