#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    tmux

echo "source $SCRIPT_DIR/tmux.conf" >> ~/.tmux.conf
echo "source $SCRIPT_DIR/tmux.session.conf" >> ~/.tmux.session.conf
