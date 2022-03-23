#!/bin/bash

echo "Installing ProtonVPN"
URL=$(curl https://protonvpn.com/support/linux-ubuntu-vpn-setup/ |\
     grep all.deb |\
     sed -n 's:.*href="\(.*\)">.*:\1:p' |\
     cut -d\" -f1)
FILENAME=$(basename $URL)
wget -c "${URL}"
sudo apt install "./${FILENAME}"
sudo apt update
sudo apt install -y protonvpn
if [[ -f "/usr/bin/gnome-shell" ]]; then
  sudo apt install -y gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
fi
rm "./${FILENAME}"

