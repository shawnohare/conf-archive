# NOTE: Finding conf home won't work if another makefile is included.
# It is assumed that this make file is run from within the root directory.

# Paths are relative to where make is invoked.
# root:= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
# home:=$(root)home
# bin:= $(root)bin
XDG_CACHE_HOME ?= "${HOME}/.cache"
XDG_CONFIG_HOME ?= "${HOME}/.config"
XDG_BIN_HOME ?= "${HOME}/.local/bin"
XDG_DATA_HOME ?= "${HOME}/.local/share"
XDG_OPT_HOME ?= "${HOME}/.local/opt"

.PHONY: dirs link unlink brew go nix python rust stack toolchains install

init: dirs stash link
	$(info Please restart another shell session.)

stash:
	$(info Updating stash symlink manager.)
	[ -d "$(XDG_OPT_HOME)/stash" ] || git clone https://github.com/shawnohare/stash "$(XDG_OPT_HOME)/stash"
	make -f "$(XDG_OPT_HOME)/stash/Makefile" install

link:
	stash -v -f -t "${HOME}" home

unlink:
	stash -v -f -D -t "${HOME}" home

dirs:
	# sudo mkdir -p /usr/local/opt
	# sudo mkdir -p /usr/local/share
	# sudo mkdir -p /usr/local/bin
	# sudo chmod 775 /usr/local/opt
	mkdir -p "${HOME}/.local/bin"
	mkdir -p "${HOME}/.local/share"
	mkdir -p "${HOME}/.local/opt"
	mkdir -p "${HOME}/.cache"
	mkdir -p "${HOME}/.config"
	mkdir -p "${XDG_BIN_HOME}"
	mkdir -p "${XDG_CONFIG_HOME}"
	mkdir -p "${XDG_CACHE_HOME}"
	mkdir -p "${XDG_DATA_HOME}"
	mkdir -p "${XDG_OPT_HOME}"
	mkdir -p "${HOME}/bin"
	mkdir -p "${HOME}/src"
	mkdir -p "${HOME}/tmp"

pkgs:
	$(bin)/pkgs

brew:
	bin/brew/install
	# bash -l brew bundle $(HOME)/etc/brew/Brewfile
	brew bundle $(HOME)/etc/brew/Brewfile

python:
	# bash -l $(bin)/python/install
	bin/python/install

rust:
	bin/rust/install

go:
	bin/go/install

nix:
	# bash -l $(bin)/nix/install
	# bash -l $(bin)/nix/pkgs

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
# .ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup


toolchains: python go rust stack

install: python
