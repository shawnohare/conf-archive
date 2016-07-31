# Some notes / commands to bootstrap an ec2 instance.
# TODO consider adding just as part of a single ec2 script
# and invoking via something like ec2 debian setup

debian_init() {
  # Make initial dirs
  sudo mkdir -p /usr/local/var
  # FIXME: make this more secure?
  sudo chmod 777 /usr/local/var # kidna dangerous

  # install a few essential packages
  sudo apt-get install git
  sudo apt-get install curl
  sudo apt-get install screen

  # initial attempt to get neovim working
  # update APT config
  echo "new line of text" | sudo tee -a /etc/apt/sources.list


  # pyenv
  readonly PYENV_ROOT="${PYENV_ROOT:-/usr/loca/var/pyenv}"
  # one reason not to abandon it is that it seems neovim needs the python host
  # path hardcoded, which is not very portable for ec2 and such.
  sudo curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash


}

main() {
  debian_init
}

main "${@}"
