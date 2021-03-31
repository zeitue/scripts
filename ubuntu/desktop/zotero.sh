#!/bin/bash

# Zotero

echo "Installing Zotero"

wget -qO - "https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/zotero.gpg
echo "deb https://github.com/retorquere/zotero-deb/releases/download/apt-get/ ./" |\
    sudo dd status=none of=/etc/apt/sources.list.d/zotero.list

sudo apt update
sudo apt install -y zotero

# Change desktop entry name
sed -e s/Juris-M/Zotero/g /usr/share/applications/zotero.desktop |\
    sudo dd status=none of=/usr/local/share/applications/zotero.desktop
