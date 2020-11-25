#!/bin/bash

# OpenRazer

echo "Installing OpenRazer"

sudo apt install -y software-properties-gtk
sudo add-apt-repository -y ppa:openrazer/stable

sudo apt update
sudo apt install -y openrazer-meta


# Add users to group
if groups $USER | grep -q '\bdomain users\b'; then
    for u in $(wbinfo -u); do
        sudo usermod -a -G plugdev $u;
    done
else
    sudo usermod -a -G plugdev $USER
fi
