#!/bin/bash

echo "Installing ProtonVPN"
URL=$(curl https://protonvpn.com/support/linux-ubuntu-vpn-setup/ |\
     grep all.deb |\
     sed -n 's:.*href="\(.*\)">.*:\1:p' |\
     cut -d\" -f1)
FILENAME=$(basename "$URL")

wget -c "$URL"
sudo apt install "./$FILENAME"
sudo apt update
sudo apt install -y protonvpn
rm "./$FILENAME"


