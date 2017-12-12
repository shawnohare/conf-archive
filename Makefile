# Finding conf home won't work if another makefile is included.
conf_home := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
bin := $(conf_home)bin

.PHONY: link unlink brew go nix python rust stack toolchains

# Assumes we have run ./configure, which sources env and profile.
# Link files, install toolchains / package managers.
all: link toolchains
	$(bin)/setup/zsh

link:
	$(bin)/link

unlink:
	$(bin)/unlink

brew:
	$(info Installing brew package manager.)
	$(bin)/brew/install
	bash -l brew bundle $(HOME)/etc/brew/Brewfile

python:
	$(info Installing python toolchain.)
	$(bin)/python/install

rust:
	$(info Installing rust toolchain via rustup.)
	test -d "${USER_LOCAL_HOME}/cargo" || (curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path)
	bash -l $(bin)/rust/pkgs

go:
	$(info Installing go toolchain.)
	$(bin)/go/install
	bash -l $(bin)/go/pkgs

nix:
	$(info Installing nix package manager.)
	test -d /nix || curl "https://nixos.org/nix/install" | sh
	# bash -l $(bin)/nix/pkgs
	# exec bash -l && nix-env -iA nixpkgs.local

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
.ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup


# NOTE: brew not installed by the script.
toolchains: python nix go rust stack
