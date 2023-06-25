#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    nodejs

cd ${SCRIPT_DIR}
curl https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
ln -s ./nvim.appimage  /usr/bin/nvim

cd ~/.config
git clone https://github.com/Hori3538/nvim.git


echo "export EDITOR='nvim'" >> ~/.bashrc
echo "alias nv='nvim'" >> ~/.bashrc
