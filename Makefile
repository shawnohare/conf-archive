# Finding conf home won't work if another makefile is included.
conf_home := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
conf_bin_home := $(conf_home)bin
dirs_to_link := alacritty \
		bash \
    fish \
    git \
    ipython \
    nix \
    nvim \
    profile \
    screen \
    spacemacs \
    stack \
    tmux \
    vim \
    zsh

# Assumes we have run ./configure, which sources env and profile.
# Link files, install toolchains / package managers.
init: link toolchains
	$(info installializing: Link config files and install toolchains.)


link:
	$(conf_bin_home)/link $(dirs_to_link)

install:
	$(info Installing packages used by the system)
	$(conf_bin_home)/setup/zsh

# Installs language toolchains, package managers, etc.
toolchains: install/python install/rust install/go install/nix install/stack

install/python:
	$(info Installing python toolchain.)
	$(conf_bin_home)/install/python

install/rust:
	$(info Installing rust toolchain via rustup.)
	test -d "${USER_LOCAL_HOME}/cargo" || (curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path)

install/go:
	$(info Installing go toolchain.)
	$(conf_bin_home)/install/go

install/nix:
	$(info Installing nix package manager.)
	test -d /nix || curl "https://nixos.org/nix/install" | sh

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
# Hence the escaped lines
.ONESHELL:
install/stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup

# packages: 
