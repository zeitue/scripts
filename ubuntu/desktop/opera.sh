#!/bin/bash

# Opera

echo "Installing Opera"
wget -qO - "https://deb.opera.com/archive.key" |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/opera.gpg
echo "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" |\
    sudo dd status=none of=/etc/apt/sources.list.d/opera-stable.list

# Update Opera with the system
echo opera-stable opera-stable/add-deb-source select true | sudo debconf-set-selections
sudo apt update
sudo apt install -y opera-stable
