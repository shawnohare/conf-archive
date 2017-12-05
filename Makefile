# Finding conf home won't work if another makefile is included.
conf_home := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
conf_bin_home := $(conf_home)bin

.PHONY: brew go nix python rust stack toolchains

# Assumes we have run ./configure, which sources env and profile.
# Link files, install toolchains / package managers.
init: link toolchains
	$(info installializing: Link config files and install toolchains.)

link:
	$(conf_bin_home)/link

install:
	$(info Installing packages used by the system)
	$(conf_bin_home)/setup/zsh

# Installs language toolchains, package managers, etc.
toolchains: brew go nix python rust stack

brew:
	$(info Installing brew package manager.)
	$(conf_bin_home)/install/brew


python:
	$(info Installing python toolchain.)
	$(conf_bin_home)/install/python

rust:
	$(info Installing rust toolchain via rustup.)
	test -d "${USER_LOCAL_HOME}/cargo" || (curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path)

go:
	$(info Installing go toolchain.)
	$(conf_bin_home)/install/go

nix:
	$(info Installing nix package manager.)
	test -d /nix || curl "https://nixos.org/nix/install" | sh

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
# Hence the escaped lines
.ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup

# packages:
