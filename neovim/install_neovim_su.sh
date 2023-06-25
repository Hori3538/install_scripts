#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    nodejs

cd ${SCRIPT_DIR}
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
ln -s ./nvim.appimage  /usr/bin/nvim

cd ~/.config
git clone https://github.com/Hori3538/nvim.git


echo "export EDITOR='nvim'" >> ~/.bashrc
echo "alias nv='nvim'" >> ~/.bashrc
