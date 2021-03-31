#!/bin/bash

# Balena Etcher

echo "Installing Balena Etcher"
echo "deb https://deb.etcher.io stable etcher" |\
    sudo dd status=none of=/etc/apt/sources.list.d/balena-etcher.list
wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x379CE192D401AB61" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/balena-etcher.gpg
sudo apt update
sudo apt install -y balena-etcher-electron
