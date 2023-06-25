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

echo "$password" | apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    wget


cd ${SCRIPT_DIR}
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
mv nvim-linux64 /
sudo ln -sf /nvim-linux64/bin/nvim  /usr/bin/nvim

# install nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
sudo apt-get install -y nodejs

cd ~/.config
git clone https://github.com/Hori3538/nvim.git


echo "export EDITOR='nvim'" >> ~/.bashrc
echo "alias nv='nvim'" >> ~/.bashrc
