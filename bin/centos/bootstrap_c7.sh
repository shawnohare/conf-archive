# Initial commands to set up a centos7 machine for basic data science work.

# Personal configs
sudo yum install -y git wget curl
if [[ ! -e "${HOME}/conf" ]]; then
	git clone --depth=1 https://github.com/shawnohare/conf "${HOME}/conf"
fi
source ~/conf/home/.profile
cd ~/conf && make init

# -----------------------------------------------------------------------------
# pyenv install, could also use from personal config files, but do the following first
sudo yum install -y xz gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
# curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# install zsh
sudo yum install -y zsh
sudo echo $(which zsh) >> /etc/shells
sudo chsh -s $(which zsh) centos

# -----------------------------------------------------------------------------
# FIXME: could not get the dnf install to work. Missing some package?
# dnf - yum replacement used on centos8. Cannot install from epel anymore...
# sudo yum install epel-release
# sudo yum install -y dnf
# wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//dnf-0.6.4-2.sdl7.noarch.rpm
# wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/dnf-conf-0.6.4-2.sdl7.noarch.rpm
# wget http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/python-dnf-0.6.4-2.sdl7.noarch.rpm
# sudo yum install dnf-0.6.4-2.sdl7.noarch.rpm dnf-conf-0.6.4-2.sdl7.noarch.rpm python-dnf-0.6.4-2.sdl7.noarch.rpm



# -----------------------------------------------------------------------------
# FIXME: Can also install tmux 3.1+ via conda. Delete these instructions?
# Unclear the advantages / disadvantageous of system tmux. Maybe other
# users on the machine could not view a user copy of tmux.
# tmux 2.9a
# sudo yum install -y gcc kernel-devel make ncurses-devel libevent-devel
# wget https://github.com/tmux/tmux/releases/download/2.9a/tmux-2.9a.tar.gz
# tar -xvzf tmux-2.9a.tar.gz
# cd tmux-2.9a
# LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
# make
# sudo make install


# neovim
# sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# sudo yum install neovim


# -----------------------------------------------------------------------------
# linuxbrew
# FIXME: linuxbrew will install gcc 5.5 which breaks 4.8.5 used by centos7
# UPDATE: 2020-07-24T21:16:48-0700: conda supports a c-compiler and compilers
# metapackage that will install an ABI compatible c-compiler.
sudo yum install -y perl-devel
sudo yum groupinstall -y 'Development Tools'
sudo yum install -y curl file git
sudo yum install -y libxcrypt-compat # needed by Fedora 30 and up
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brewed neovim
brew install gcc glibc
brew install neovim --HEAD


