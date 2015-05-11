# Where auto-sourced zsh config files reside.
export ZDOTDIR=${HOME}/.zsh
# Location of dotfiles repo.
export DOTDIR=${HOME}/dotfiles

export EDITOR="vim"
export VISUAL="vim"

# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi
