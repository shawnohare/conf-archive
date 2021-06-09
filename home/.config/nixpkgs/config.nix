# install the user env packages via nix-env -iA nixpkgs.{gui,cli}
# NOTE: Installing specific versions.
# https://github.com/NixOS/nixpkgs/issues/9682
# https://github.com/NixOS/nixpkgs/issues/93327
# https://www.tweag.io/blog/2020-05-25-flakes/
{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    # uncomment to create nix specific profiles to source
    # myProfile = writeText "my-profile" ''
    #   export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/sbin:/bin:/usr/sbin:/usr/bin
    #   export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:/usr/share/man
    #   export INFOPATH=$HOME/.nix-profile/share/info:/nix/var/nix/profiles/default/share/info:/usr/share/info
    # '';
    # TODO: Need to figure out how to launch gui applications
    gui = pkgs.buildEnv {
      name = "core-gui-packages";
      paths = [
        alacritty
      ];
    };
    # Common cli packages
    cli = pkgs.buildEnv {
      name = "core-cli-packages";
      paths = [
        # We can create nix-specific profiles to source via:
        # (runCommand "profile" {} ''
        #   mkdir -p $out/etc/profile.d
        #   cp ${myProfile} $out/etc/profile.d/my-profile.sh
        # '')
        aspell
        bc
        coreutils
        git
        htop
        jq
        man
        nixFlakes
        nox
        niv
        ripgrep
        starship
        texinfoInteractive
        tmux
        wget
        # installing zsh through nix might cause some bootstrap issues
        zsh
        # NOTE: Not all zsh plugins we use are available, e.g., autopair
        # TODO: These files need to be sourced in zshrc. nix puts them in
        # various places within ~/.nix-profile/share
        zsh-autosuggestions
        zsh-completions
        zsh-history
        zsh-history-substring-search
        zsh-syntax-highlighting
        nix-zsh-completions
        z-lua
      ];
      # pathsToLink = [ "/share/man" "/share/doc" "/share/info" "/bin" "/etc" ];
      extraOutputsToInstall = [ "man" "doc" "info" ];
      # install info pages
      postBuild = ''
        if [ -x $out/bin/install-info -a -w $out/share/info ]; then
          shopt -s nullglob
          for i in $out/share/info/*.info $out/share/info/*.info.gz; do
              $out/bin/install-info $i $out/share/info/dir
          done
        fi
      '';
    };
  };
}

# {
#   allowUnfree = true;
#   packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages
#     # Install some core programs in an OS independent way.
#     # pkgs is your overriden set of packages itself
#     local = with pkgs; buildEnv {
#       name = "local";
#       paths = [
#         awscli
#         # regular bash is not meant for interactive use.
#         # bashInteractive
#         # NOTE: There has been some issues with darwin's outdated openssl cert
#         # and how nix sets SSL_CERT_FILE. See:
#         # https://github.com/NixOS/nix/issues/921
#         # After installing openssl via homebrew, curl broke with the error
#         # described in: https://github.com/NixOS/nix/issues/921
#         # `unset SSL_CERT_FILE` and using the system `curl` allows
#         # builtin curl to function again.
#         # cacert
#         # clang
#         # cmake
#         # coreutils-prefixed # Things like gls
#         # curl
#         # exa # errors when compiling
#         # fira-code
#         fish
#         fzf
#         git
#         gnumake
#         hack-font
#         hasklig
#         # FIXME 2016-09-15T06:56:15-0700
#         # Go builds having trouble.
#         # "go-1.7" # this seems to install go without std lib?
#         # hugo
#         htop
#         jq
#         mosh
#         # neovim
#         nix-zsh-completions
#         # nox
#         pandoc
#         # pass
#         # NOTE: Python installation through nix was fraught with issues.
#         # python27Full
#         # python27Packages.pip
#         # python27Packages.virtualenv
#         # python27Packages.bcrypt
#         # python35
#         # python35Packages.flake8
#         # python35Packages.ipython
#         # python35Packages.pylint # errored on os x
#         # python35Packages.pew # virtualenv tool, but venv path below nix's
#         # pew
#         openssl
#         # ripgrep
#         # source-code-pro # font
#         screen
#         shellcheck
#         # silver-searcher
#         sqlite
#         # 2017-05-04 encountered a stack build error
#         # stack # haskell build tool
#         stow
#         tmux
#         wget
#         # zsh To avoid bootstrap issues, install through other means
#       ];
#     };

#     # Unknown errors.
#     # rustpkgs = with pkgs; buildEnv {
#     #   name = "rustpkgs";
#     #   paths = [
#     #     exa
#     #     ripgrep
#     #     vis
#     #   ];
#     # };

#     vms = with pkgs; buildEnv {
#       name = "vms";
#       paths = [
#         vagrant
#         # virtualbox # virtualbox not supported for macos
#         docker
#       ];
#     };
#   };
# }

