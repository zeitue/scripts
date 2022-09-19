#!/bin/bash

# Typora

echo "Installing Typora"

wget -qO - "https://typora.io/linux/public-key.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/typora.gpg

sudo add-apt-repository -y 'deb https://typora.io/linux ./'
sudo apt update
sudo apt install -y typora pandoc

