#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

set_password()
{
    if [ ! ${password} ]
    then
        printf "password: "
        read -s password
    fi
}
set_password

echo "$password" | sudo apt-get update
sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    software-properties-common
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    vim

cd ~
git clone https://github.com/Hori3538/vim_conf.git
cd vim_conf && ./reset_vim_conf.sh

echo "alias v=vim" >> ~/.bashrc
source ~/.bashrc
