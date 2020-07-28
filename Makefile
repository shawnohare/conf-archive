# NOTE: Finding conf home won't work if another makefile is included.
# It is assumed that this make file is run from within the root directory.

# Paths are relative to where make is invoked.
# root:= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
# home:=$(root)home
# bin:= $(root)bin
# TODO: Some parts should probably be split into a separate distro specific
# Makefile, e.g., ~/conf/$distro/Makefile
XDG_CACHE_HOME ?= "${HOME}/.cache"
XDG_CONFIG_HOME ?= "${HOME}/.config"
XDG_BIN_HOME ?= "${HOME}/.local/bin"
XDG_DATA_HOME ?= "${HOME}/.local/share"
XDG_OPT_HOME ?= "${HOME}/.local/opt"
XDG_SRC_HOME ?= "${HOME}/.local/src
op_pkg := "op_linux_amd64_v0.5.7.zip"
albert_pkg := "albert_0.16.1_amd64.deb"

.PHONY: dirs link unlink brew go nix python rust stack toolchains install

init: dirs stash link
	$(info Please restart another shell session to ensure proper env.)

ubuntu-init: init
	$(info Installing common apps)
	sudo apt -y install git curl wget jq software-properties-common

ubuntu-server: ubuntu-init /usr/bin/nvim
	sudo apt -y install zsh tmux
	chsh -s $$(which zsh)

ubuntu-desktop: ubuntu-server /usr/bin/alacritty /usr/bin/albert
	sudo apt -y install i3 rofi

$(XDG_BIN_HOME)/op:
	mkdir -p $(XDG_OPT_HOME)/op
	cd $(XDG_OPT_HOME)/op && wget https://cache.agilebits.com/dist/1P/op/pkg/v0.5.7/$(op_pkg)
	unzip $(XDG_OPT_HOME)/op/$(op_pkg)
	ln -s $(XDG_OPT_HOME)/op/op $(XDG_BIN_HOME)/op

/usr/local/src/$(albert_pkg):
	cd /usr/local/src && sudo wget https://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_19.04/amd64/$(albert_pkg)

/usr/bin/albert: /usr/local/src/$(albert_pkg)
	sudo apt -y install $<

/usr/bin/nvim:
	$(info Installing neovim dev)
	# sudo apt -y install npm
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt -y install neovim

$(RUSTUP_HOME):
	curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path -y
	# bin/rust/install

$(CARGO_HOME)/bin/cargo-deb:
	cargo install cargo-deb

$(XDG_OPT_HOME)/xst:
	git clone https://github.com/gnotclub/xst $@

/usr/local/bin/xst: $(XDG_OPT_HOME)/xst
	sudo make -C $< install

rust: $(RUSTUP_HOME)

$(XDG_OPT_HOME)/alacritty:
	git clone https://github.com/jwilm/alacritty $@

/usr/bin/alacritty: $(XDG_OPT_HOME)/alacritty $(RUSTUP_HOME) $(CARGO_HOME)/bin/cargo-deb
	$(info Installing alacritty)
	sudo apt -y install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
	cargo deb --install --manifest-path $(XDG_OPT_HOME)/alacritty/alacritty/Cargo.toml

ubuntu-alacritty: /usr/bin/alacritty

$(XDG_OPT_HOME)/stash:
	git clone https://github.com/shawnohare/stash $@

stash: $(XDG_OPT_HOME)/stash
	make -C $< install

link:
	stash -v -f -t "${HOME}" home
	# stash -v -f -t "${XDG_CONFIG_HOME}/zsh" home/.config/zsh

unlink:
	stash -v -f -D -t "${HOME}" home

dirs:
	# sudo mkdir -p /usr/local/opt
	# sudo mkdir -p /usr/local/share
	# sudo mkdir -p /usr/local/bin
	# sudo chmod 775 /usr/local/opt
	mkdir -p "${XDG_BIN_HOME}"
	ln -s -f "${XDG_BIN_HOME}" "${HOME}/bin"
	mkdir -p "${XDG_CONFIG_HOME}"
	ln -s -f "${XDG_CONFIG_HOME}" "${HOME}/etc"
	mkdir -p "${XDG_CACHE_HOME}"
	mkdir -p "${XDG_DATA_HOME}"
	ln -s -f "${XDG_DATA_HOME}" "${HOME}/share"
	mkdir -p "${XDG_OPT_HOME}"
	ln -s -f "${XDG_OPT_HOME}" "${HOME}/opt"
	mkdir -p "${XDG_SRC_HOME}"
	ln -s -f "${XDG_SRC_HOME}" "${HOME}/src"
	mkdir -p "${HOME}/tmp"
	mkdir -p "${XDG_DATA_HOME}/man/man1"
	mkdir -p "${XDG_DATA_HOME}/man/man2"
	mkdir -p "${XDG_DATA_HOME}/man/man4"
	mkdir -p "${XDG_DATA_HOME}/man/man4"
	mkdir -p "${XDG_DATA_HOME}/man/man5"
	mkdir -p "${XDG_DATA_HOME}/man/man6"
	mkdir -p "${XDG_DATA_HOME}/man/man7"
	mkdir -p "${XDG_DATA_HOME}/man/man8"
	mkdir -p "${XDG_DATA_HOME}/man/man8"
	# sudo mkdir -p /usr/local/share/man/man1
	# sudo mkdir -p /usr/local/share/man/man2
	# bash and zsh cannot create dirs for history files.
	mkdir -p "${XDG_DATA_HOME}/bash"
	mkdir -p "${XDG_DATA_HOME}/zsh"
	mkdir -p "${XDG_DATA_HOME}/starship"

pkgs:
	$(bin)/pkgs

/usr/local/bin/brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew: /usr/local/bin/brew

python:
	# bash -l $(bin)/python/install
	bin/pyenv/install
	bin/conda/install

# rust:
#	bin/rust/install

# go:
#	bin/go/install

# nix:
	# bash -l $(bin)/nix/install
	# bash -l $(bin)/nix/pkgs

# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
# .ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup

starship:
	# Create init files
	starship init zsh --print-full-init > "${XDG_DATA_HOME}/starship/init.zsh"
	starship init bash --print-full-init > "${XDG_DATA_HOME}/starship/init.sh"
	starship init fish --print-full-init > "${XDG_DATA_HOME}/starship/init.fish"

