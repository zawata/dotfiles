#! /usr/bin/env bash

#
# Environment Initialization
#

# packages I need
sudo pamac install fortune
sudo pamac build visual-studio-code-bin

#packages I don't need
sudo pamac remove kate xterm

# install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install rustup
curl https://sh.rustup.rs -sSf | sh
rustup update

# install vcpkg
cd /opt/
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap.sh -disableMetrics

