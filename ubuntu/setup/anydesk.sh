#!/bin/bash

# AnyDesk

echo "Installing AnyDesk"
wget -qO - "https://keys.anydesk.com/repos/DEB-GPG-KEY" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/anydesk-stable.list

# Patch up missing package
wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb
sudo apt install ./libpangox-1.0-0_0.0.2-5.1_amd64.deb
rm libpangox-1.0-0_0.0.2-5.1_amd64.deb

sudo apt update
sudo apt install -y anydesk

