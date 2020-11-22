#!/bin/bash

# ONLYOFFICE Desktop Editors

echo "Installing ONLYOFFICE Desktop Editors"

wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xCB2DE8E5" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/onlyoffice-desktopeditors.gpg

echo "deb https://download.onlyoffice.com/repo/debian squeeze main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/onlyoffice-desktopeditors.list

# Accept license for MS fonts
echo msttcorefonts msttcorefonts/accepted-mscorefonts-eula select true |\
    sudo debconf-set-selections

sudo apt update
sudo apt install -y onlyoffice-desktopeditors
