#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    wget

cd ${SCRIPT_DIR}
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
mv nvim-linux64 /
ln -sf /nvim-linux64/bin/nvim  /usr/bin/nvim

# install nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs

CONFIGDIR=~/.config
if [ ! -d $CONFIGDIR ]; then
  mkdir $CONFIGDIR
fi
cd CONFIGDIR
git clone https://github.com/Hori3538/nvim.git


echo "export EDITOR='nvim'" >> ~/.bashrc
echo "alias nv='nvim'" >> ~/.bashrc
