#!/bin/bash

# Yarn

echo "Installing Yarn"

echo "deb https://dl.yarnpkg.com/debian/ stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/yarn.list

wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/yarn.gpg

sudo apt update

sudo apt install -y yarn

