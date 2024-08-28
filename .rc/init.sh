#! /usr/bin/env bash

#
# Environment Initialization
#

## Package installation

# official packagaes
sudo pamac install alacritty firefox flameshot fortune-mod noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# tools/utilities
sudo pamac install docker docker-compose dog feh nmap gnu-netcat htop

# AUR packages
sudo pamac build 1password awsvpnclient etcher-cli-bin httpie-desktop-bin via-bin visual-studio-code-bin

# install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install rustup
curl https://sh.rustup.rs -sSf | sh
rustup update

# install vcpkg
# cd /opt/
# mkdir vcpkg
# sudo chown $USER vcpkg
# git clone https://github.com/Microsoft/vcpkg.git
# cd vcpkg
# ./bootstrap-vcpkg.sh -disableMetrics

