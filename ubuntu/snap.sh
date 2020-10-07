#!/bin/bash

# setup snap
# install the snapd daemon
if [ -f "/etc/apt/preferences.d/nosnap.pref" ]; then
    sudo rm /etc/apt/preferences.d/nosnap.pref
    sudo apt update
fi

sudo apt install -y snapd

# don't keep too many snaps around
sudo snap set system refresh.retain=2

# install the snap store
sudo snap install snap-store

