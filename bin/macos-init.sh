
# ---------------------------------------------------------------------------
# macos Specific functions
# This was originally part of the config helper script, but was split out
# to avoid having to switch on OS type constantly.
# ---------------------------------------------------------------------------

# FIXME: maybe just make the initial init phase manual.
# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
install_xcode() {
  if ! (xcode-select --print-path 1>/dev/null); then
    echo "Installing xcode command line tools."
    (xcode-select --install)
  else
    $debug && echo "Xcode command line tools are already installed."
  fi
}

# In bash, hash <command> exits with with 0 iff the command exists.
install_homebrew() {
  if ! cmd_exists "brew"; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    $debug && echo "Homebrew already installed."
  fi
}

init() {
  macos_install_xcode
  # macos_install_homebrew
  return 0
}
