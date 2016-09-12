{
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    myenv = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "myenv";
      paths = [
        awscli
        # cacert
        curl
        git
        hugo # static site generator
        # "go-1.7" # this seems to install go without std lib?
        neovim
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
        silver-searcher
        sqlite
        stow
        tmux
        wget
        zsh
      ];
    };
  };
}
