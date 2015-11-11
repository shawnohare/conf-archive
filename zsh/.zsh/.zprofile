# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.

# ==========================================================================
# PATH 
# ==========================================================================

# Generic binaries
# Make sure ~/.local/bin, ~/bin, and usr/local/bin occurs before usr/bin.
PATH="${HOME}/.local/bin:$PATH"
PATH="${HOME}/bin:$PATH"

# --------------------------------------------------------------------------
# Haskell
# --------------------------------------------------------------------------

# GHC For MAC OS X
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
if [[ -d "$GHC_DOT_APP" ]]; then
  PATH="${GHC_DOT_APP}/Contents/bin:${PATH}"
  PATH="${HOME}/.cabal/bin:${PATH}"
fi

# Look for haskell tools installed by stack
# FIXME: remove?
# PATH="${HOME}/.stack/programs/:${PATH}"
# Use haskell tools in the current sandbox/stack maintained dir. FIXME remove?
# PATH=".cabal-sandbox/bin:${PATH}"
PATH=".stack_work:${PATH}"

# --------------------------------------------------------------------------
# golang
# --------------------------------------------------------------------------
export GOPATH="${HOME}/dev/go"
PATH="${GOPATH}/bin:${PATH}"

# --------------------------------------------------------------------------
# Python
# --------------------------------------------------------------------------

# pyenv
# Use homebrew's directories rather than ~/.pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
# pyenv init will use PYENV_ROOT or default to ~/.pyenv
if hash pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#eval "$(pyenv virtualenv-init -)"


export PATH


