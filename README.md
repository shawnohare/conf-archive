# User configuration files

# Introduction

These config files are organized to take advantage of the symlink farm manager
system GNU `stow`.  Config files are generally organized topically, and the
structure of each directory mirrors what it should look like when it the entire
contents are symlinked into the appropriate target, usually `$HOME`.

We prefer a BSD-like user home directory structure that also services
applications utilizing the XDG conventions.

In order to maintain a measure of robustness to change, some steps that could
be automated are specifically made manual. It is our experience that
automatation maintenance costs increase hyper-linearly with volatility.


# Installation

Some manual initialization leads to less headaches.

## Initialization

Some basic system tools are necessary before running the config install script.
These are: `curl`, `git`, `bzip`.  

### macos

All the tools above can be installed via:

```bash
xcode-select --install
```

### Debian-based

```bash
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y curl git bzip
```

## Install script

Next, the config install script must be run. 

The preferred method is:
```bash
git clone https://github.com/shawnohare/conf
cd conf
bin/install
```

Alternatively:
```bash
curl https://raw.githubusercontent.com/shawnohare/conf/master/bin/install | bash
```

#  Manual post-install steps

- Download `iterm` for macOS and install the associated shell integration
  script via iterm, if desired.
- Tell `iterm` to look in `~/conf/iterm/` for its config.
- Delete the spurious `~/.zshrc` file created by the iterm shell integration
  install. This is an unfortunate consequence of specifying a custom
  `ZDOTDIR` directory.


# Development

1. Install `golang` via `sudo bin/init/golang`. 
1. Install `rust` via `bin/init/rust` or `curl https://sh.rustup.rs -sSf | sh`


# Profile 

1. `~/.env` file exports common user environment variables.
2. `~/.profile` sources the user env file above and sets the path.
3. Shell specific startup scripts (e.g., `~/.zshenv`)should source `~/.profile`.
