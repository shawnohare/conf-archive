{
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    mydev = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "mydev";
      paths = [
        cacert
        curl
        git
        go
        neovim
        nix-zsh-completions
        nox
        python27Full
        python27Packages.pip
        python27Packages.virtualenv
        python35
        python35Packages.ipython
        # python35Packages.pew # virtualenv tool, but venv path below nix's
        silver-searcher
        stow
        tmux
        zsh
      ];
    };
  };
}
