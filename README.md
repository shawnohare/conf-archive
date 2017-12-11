# User configuration files

# Introduction

Simplicity, speed and portability take precedence over the elaborate and general-purpose.

The configuration files are organized to take advantage of a basic
symlink farm manager similar to `stow`. For example, the tree structure of
`src` is symlinked to `$HOME`, except that directories are actually created
so that app data files do not unexpectedly appear in this repository.

Generally, the file organization is inspired by BSD and the XDG spec.


# Manual Initialization

Some basic system tools are necessary before running the config install script.
These are: `curl`, `git`, `bzip`.  

## macos

All the tools above can be installed via:

```bash
xcode-select --install
```

## Debian-based

```bash
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y curl git bzip
```

# Install script

Next, the config install script must be run. 

The preferred method is:
```bash
git clone https://github.com/shawnohare/conf
~/conf/bin/install
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
- Remove any lines added automatically by installers such as nix, go, cargo.
- Allow macos admin users to use sudo without passwords: `sudo visudo` and
  edit `%admin ALL=(ALL) ALL` to `%admin ALL=(ALL) NOPASSWD:ALL`.


# Development

1. Install `golang` via `sudo bin/init/golang`. 
1. Install `rust` via `bin/init/rust` or `curl https://sh.rustup.rs -sSf | sh`


# Profile 

1. `~/.env` file exports common user environment variables.
2. `~/.profile` sources the user env file above and sets the path.
3. Shell specific startup scripts (e.g., `~/.zshenv`)should source `~/.profile`.
