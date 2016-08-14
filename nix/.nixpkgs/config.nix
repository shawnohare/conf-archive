{
  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
    core = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "core";
      paths = [
        git
        go
        nix-zsh-completions
        nox
        silver-searcher
        stow
        tmux
        zsh
      ];
    };
  };
}
