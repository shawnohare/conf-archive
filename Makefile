# NOTE: Finding conf home won't work if another makefile is included.
# It is assumed that this make file is run from within the root directory.

# Paths are relative to where make is invoked.
root:= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
home:=$(root)home
bin:= $(root)bin
# TODO: Some parts should probably be split into a separate distro specific
# Makefile, e.g., ~/conf/$distro/Makefile
XDG_CACHE_HOME ?= "${HOME}/.cache"
XDG_CONFIG_HOME ?= "${HOME}/.config"
XDG_BIN_HOME ?= "${HOME}/.local/bin"
XDG_DATA_HOME ?= "${HOME}/.local/share"
XDG_OPT_HOME ?= "${HOME}/.local/opt"
XDG_SRC_HOME ?= "${HOME}/.local/src"
conda := "$(CONDA_ROOT)/condabin/conda"

.PHONY: mkdirs link unlink brew go nix python rust stack toolchains install

init: mkdirs stash link
	$(info Please restart another shell session to ensure proper env.)

$(XDG_OPT_HOME)/stash:
	git clone https://github.com/shawnohare/stash $@

stash: $(XDG_OPT_HOME)/stash
	make -C $< install

link:
	stash -f -t "${HOME}" home
	ln -sfh "${XDG_BIN_HOME}" "${HOME}/bin"
	ln -sfh "${XDG_CONFIG_HOME}" "${HOME}/etc"
	ln -sfh "${XDG_DATA_HOME}" "${HOME}/share"
	ln -sfh "${XDG_OPT_HOME}" "${HOME}/opt"
	ln -sfh "${XDG_SRC_HOME}" "${HOME}/src"
	ln -sfh "${XDG_VAR_HOME}" "${HOME}/var"
	# bins
	ln -sf "${POETRY_HOME}/bin/poetry" "${XDG_BIN_HOME}/poetry"
	ln -sf "${CONDA_ROOT}/condabin/conda" "${XDG_BIN_HOME}/conda"
	ln -sf "${CONDA_ROOT}/condabin/mamba" "${XDG_BIN_HOME}/mamba"
	# stash -v -f -t "${XDG_CONFIG_HOME}/zsh" home/.config/zsh

unlink:
	stash -v -f -D -t "${HOME}" home

mkdirs:
	# sudo mkdir -p /usr/local/opt
	# sudo mkdir -p /usr/local/share
	# sudo mkdir -p /usr/local/bin
	# sudo chmod 775 /usr/local/opt
	mkdir -p "${XDG_BIN_HOME}"
	mkdir -p "${XDG_CONFIG_HOME}"
	mkdir -p "${XDG_CACHE_HOME}"
	mkdir -p "${XDG_DATA_HOME}"
	mkdir -p "${XDG_OPT_HOME}"
	mkdir -p "${XDG_SRC_HOME}"
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
	# bash and zsh cannotcreate mkdirs for history files.
	mkdir -p "${XDG_DATA_HOME}/bash"
	mkdir -p "${XDG_DATA_HOME}/zsh"

/usr/local/bin/brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew: /usr/local/bin/brew

python:
	# bash -l $(bin)/python/install
	bin/pyenv/install
	bin/conda/install

# go:
#	bin/go/install

# nix:
	# bash -l $(bin)/nix/install
	# bash -l $(bin)/nix/pkgs
	#

$(RUSTUP_HOME):
	curl https://sh.rustup.rs -sSf | bash -s -- --no-modify-path -y
	# bin/rust/install

$(CARGO_HOME)/bin/cargo-deb:
	cargo install cargo-deb

rust: $(RUSTUP_HOME)


# NOTE: the .ONESHELL feature is in 3.82, but macOS High Sierra has 3.81
# .ONESHELL:
stack :
	$(info Installing the Haskell build tool stack.)
	test -e "/usr/local/bin/stack" || curl -sSL "https://get.haskellstack.org/"
	/usr/local/bin/stack setup

# FIXME: There might be an issue with sourcing these init files instead of
# evaluating from the appropriate rc. It might not be possible to have the
# appropriate script sourced from subshells.
conda-init:
	# bash -l $(bin)/conda/install
	mkdir -p "${XDG_DATA_HOME}/conda"
	$(conda) shell.zsh hook > "${XDG_DATA_HOME}/conda/init.zsh"
	$(conda) shell.bash hook > "${XDG_DATA_HOME}/conda/init.bash"
	$(conda) shell.xonsh hook > "${XDG_DATA_HOME}/conda/init.xonsh"
	$(conda) shell.fish hook > "${XDG_DATA_HOME}/conda/init.fish"

pyenv-init:
	mkdir -p "${XDG_DATA_HOME}/pyenv"
	$(PYENV) init - --no-rehash bash > "${XDG_DATA_HOME}/pyenv/init.bash"
	$(PYENV) init - --no-rehash zsh > "${XDG_DATA_HOME}/pyenv/init.zsh"
	$(PYENV) init - --no-rehash fish > "${XDG_DATA_HOME}/pyenv/init.fish"

starship-init:
	# Create init files
	mkdir -p "${XDG_DATA_HOME}/starship"
	starship init zsh --print-full-init > "${XDG_DATA_HOME}/starship/init.zsh"
	starship init bash --print-full-init > "${XDG_DATA_HOME}/starship/init.bash"
	starship init fish --print-full-init > "${XDG_DATA_HOME}/starship/init.fish"

