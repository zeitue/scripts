#!/bin/bash

# Atom.io

echo "Installing Atom"
wget -qO - "https://packagecloud.io/AtomEditor/atom/gpgkey" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/atom.gpg
echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/atom.list
sudo apt update
sudo apt install -y atom

