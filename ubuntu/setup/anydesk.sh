#!/bin/bash

# AnyDesk

echo "Installing AnyDesk"
wget -qO - "https://keys.anydesk.com/repos/DEB-GPG-KEY" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/anydesk.gpg
echo "deb http://deb.anydesk.com/ all main" |\
    sudo dd status=none of=/etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install -y anydesk

