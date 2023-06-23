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
    tmux

echo "source $SCRIPT_DIR/tmux.conf" >> ~/.tmux.conf
echo "source $SCRIPT_DIR/tmux.session.conf" >> ~/.tmux.session.conf

echo "alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'" >> ~/.bashrc
source ~/.bashrc
