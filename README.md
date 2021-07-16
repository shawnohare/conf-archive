# User configuration files

# Introduction

Simplicity, speed and portability take precedence over the elaborate and general-purpose.

The configuration files are organized to take advantage of a basic
symlink farm manager similar to `stow`. For example, the tree structure of
`home/` is symlinked to `$HOME`, except that directories are actually created
so that app data files do not unexpectedly appear in this repository.

Generally, the file organization is inspired by BSD and the XDG spec.

# Future Directions (Nix)

The [Nix package manager][nixos] has matured significantly over the
past few years. I'd like to utilize the [Nix ecosystem][nix-eco] more fully
for both personal and developer configuration management.
A layer on top of Nix is [home-manager project][home-manager]
lets one specify significant portion of
one's config for various machines, users, and roles, often using the Nix
expressions for app configurations.

[Hugo Reeve's post][hugoreeves-nix-home-post] details his experience using
home-manager, and
[his home-manager configuration][hugoreeves-nix-home-repo]
looks to serve as a good example.

The [nixflk repo][nixflk] is a NixOS configuration template using flakes.
It utilies home-manager.

The [nix-darwin][nix-darwin] project is roughly equivalent to NixOS on macOS.
As per StackOverflow:

> What nix-darwin adds is configuration and service management using the same
> mechanism as NixOS and it's mostly intended for users that use or know NixOS
> and want to have some of the same features on a mac.

The [unofficial Nix community wiki][nix-wiki] looks to be a good source of
information.


[nixos]: <https://nixos.org> "NixOS"
[nix-eco]: <https://nixos.wiki/wiki/Nix_Ecosystem> "Nix Ecosystem"
[home-manager]: <https://github.com/nix-community/home-manager> "Home Manager"
[nix-wiki]: <https://nixos.wiki> "Unofficial Nix Wiki"
[nix-darwin]: <https://github.com/LnL7/nix-darwin> "Nix Darwin"
[nixflk]: <https://github.com/nrdxp/nixflk> "nixflk"
[hugoreeves-nix-home-post]: <https://hugoreeves.com/posts/2019/nix-home/>
[hugoreeves-nix-home-repo]: <https://github.com/HugoReeves/nix-home/>


# Manual Initialization

Some basic system tools are necessary before running the config install script.
These are: `curl`, `git`, `bzip`.

## macOS

Note that macOS comes with a copy of `zsh` pre-installed, so all
dependencies can be installed via

```sh
xcode-select --install
```

For `macos >= 10.14`, some additional header files might need to be installed:
```sh
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
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
