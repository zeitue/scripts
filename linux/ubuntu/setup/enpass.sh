#!/bin/bash

# Enpass

echo "Installing Enpass"

echo "deb https://apt.enpass.io/ stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/enpass.list

wget -qO - https://apt.enpass.io/keys/enpass-linux.key |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/enpass.gpg

sudo apt update
sudo apt install -y enpass
