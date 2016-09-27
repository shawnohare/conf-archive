{
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    myenv = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "myenv";
      paths = [
        awscli
        cacert  # git seems to want this
        coreutils-prefixed
        git
        # FIXME 2016-09-15T06:56:15-0700
        # Go builds having trouble.
        # "go-1.7" # this seems to install go without std lib?
        # hugo 
        # neovim # getting malloc error on macOS sierra
        nix-zsh-completions
        nox
        python27Full
        python27Packages.pip
        python27Packages.virtualenv
        python35
        # python35Packages.flake8
        python35Packages.ipython
        # python35Packages.pylint # errored on os x
        # python35Packages.pew # virtualenv tool, but venv path below nix's
        # source-code-pro # font
        silver-searcher
        sqlite
        stack # haskell build tool
        stow
        tmux
        wget
        zsh
      ];
    };
  };
}
