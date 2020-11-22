#!/bin/bash

# GitHub CLI
echo "Installing GitHub CLI"
wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC99B11DEB97541F0" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/gh.gpg
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt update
sudo apt install -y gh
