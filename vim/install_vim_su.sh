#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    software-properties-common
add-apt-repository ppa:jonathonf/vim
apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    vim

cd ~
git clone https://github.com/Hori3538/vim_conf.git
cd tmux_conf && ./reset_vim_conf.sh

echo "alias v=vim" >> ~/.bashrc
source ~/.bashrc
