#!/bin/bash

# Brave Browser

echo "Installing Brave Browser"
sudo apt install -y apt-transport-https curl
wget -qO - "https://brave-browser-apt-release.s3.brave.com/brave-core.asc" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/brave-browser-release.gpg
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
