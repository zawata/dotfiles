# packages I need
sudo pamac kitty fortune
sudo pamac build -a visual-studio-code-bin

#packages I don't need
sudo pamac remove kate konsole xterm

# install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install rustup
curl https://sh.rustup.rs -sSf | sh

# install vcpkg
cd /opt/
sudo git clone https://github.com/Microsoft/vcpkg.git
chown -R johna vcpkg
cd vcpkg
./bootstrap.sh -disableMetrics

