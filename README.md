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

## macOS

Note that macOS comes with a copy of `zsh` pre-installed, so all
dependencies can be installed via

```bash
xcode-select --install
```

## Debian-based

```bash
sudo apt update
sudo apt -y upgrade
sudo apt install -y curl git bzip zsh
# copy file with wheel (admin group w/o password requirement) to /etc/sudoers.d/wheel
## optional:
# sudo echo '%wheel   ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/wheel
# sudo usermod -a -G wheel $whoami

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

## Terminal Emulation Font Emphasis

Depending on the emulator, it might be necessary to update the compiled
terminfo files.

```bash
# 1. Output details of current terminal.
infocmp -L $TERM > ~/$TERM.terminfo
# Add codes for italics and underline.
echo '\tritm=\E[23m, sitm=\,' >> ~/$TERM.info
# Recompile new terminfo. This could be put in the home dir on some systems.
tic -o /usr/share/terminfo ~/$TERM.info

```


# Development

1. Install `golang` via `sudo bin/init/golang`.
1. Install `rust` via `bin/init/rust` or `curl https://sh.rustup.rs -sSf | sh`
