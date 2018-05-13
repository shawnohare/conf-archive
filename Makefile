# Finding conf home won't work if another makefile is included.
# NOTE: This Makefile is primarily for educational purposes. It seems
# overly tedius to use it as a bootstrap mechanism.

conf_home := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
bin := $(conf_home)bin

.PHONY: dirs link unlink brew go nix python rust stack toolchains install

init: dirs link

link:
	$(bin)/link $(conf_home)home "${HOME}"

unlink:
	$(bin)/unlink $(conf_home)home "${HOME}"

dirs:
	sudo mkdir -p /usr/local/opt
	sudo mkdir -p /usr/local/share
	sudo mkdir -p /usr/local/bin
	sudo chmod 775 /usr/local/opt
	mkdir -p "${USER_BIN_HOME}"
	mkdir -p "${USER_CONFIG_HOME}"
	mkdir -p "${USER_CACHE_HOME}"
	mkdir -p "${USER_SHARE_HOME}"
	mkdir -p "${HOME}/bin"
	mkdir -p "${HOME}/opt"
	mkdir -p "${HOME}/tmp"

pkgs:
	$(bin)/pkgs

brew:
	$(bin)/brew/install
	bash -l brew bundle $(HOME)/etc/brew/Brewfile

python:
	bash -l $(bin)/python/install

rust:
	bash -l $(bin)/rust/install
	bash -l $(bin)/rust/pkgs

go:
	bash -l $(bin)/go/install
	bash -l $(bin)/go/pkgs

nix:
	bash -l $(bin)/nix/install
	bash -l $(bin)/nix/pkgs

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
.ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup


# NOTE: brew not installed by the script.
toolchains: pkgs python go rust stack

install: link dirs pkgs
