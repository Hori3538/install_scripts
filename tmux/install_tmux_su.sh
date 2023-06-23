#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    tmux

cd ~
git clone https://github.com/Hori3538/tmux_conf.git
cd tmux_conf && ./reset_tmux_conf.sh

echo "alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'" >> ~/.bashrc
source ~/.bashrc
