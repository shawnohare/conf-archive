# Some notes / commands to bootstrap an ec2 instance.

debian_init() {
  sudo apt-get git
  sudo apt-get curl
  # pyenv
  # set PYENV_ROOT here or consider abandoning it
  # one reason not to abandon it is that it seems neovim needs the python host
  # path hardcoded, which is not very portable for ec2 and such.
  # curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash


}
