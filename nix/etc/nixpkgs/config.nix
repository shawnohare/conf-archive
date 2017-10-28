{
  allowUnfree = true;
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    # Install some core programs in an OS independent way.
    # pkgs is your overriden set of packages itself
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        awscli
        # regular bash is not meant for interactive use.
        bashInteractive
        # NOTE: There has been some issues with darwin's outdated openssl cert
        # and how nix sets SSL_CERT_FILE. See:
        # https://github.com/NixOS/nix/issues/921
        # After installing openssl via homebrew, curl broke with the error
        # described in: https://github.com/NixOS/nix/issues/921
        # `unset SSL_CERT_FILE` and using the system `curl` allows
        # builtin curl to function again.
        # cacert
        # curl
        coreutils-prefixed # Things like gls
        fira-code
        fish
        fzf
        git
        hack-font
        hasklig
        # FIXME 2016-09-15T06:56:15-0700
        # Go builds having trouble.
        # "go-1.7" # this seems to install go without std lib?
        # hugo
        htop
        jq
        mosh
        neovim
        nix-zsh-completions
        nox
        pass
        # NOTE: Python installation through nix was fraught with issues.
        # python27Full
        # python27Packages.pip
        # python27Packages.virtualenv
        # python27Packages.bcrypt
        # python35
        # python35Packages.flake8
        # python35Packages.ipython
        # python35Packages.pylint # errored on os x
        # python35Packages.pew # virtualenv tool, but venv path below nix's
        # pew
        ripgrep
        # source-code-pro # font
        screen
        shellcheck
        silver-searcher
        sqlite
        # 2017-05-04 encountered a stack build error
        # stack # haskell build tool
        stow
        tmux
        wget
        zsh
      ];
    };
  };
}

