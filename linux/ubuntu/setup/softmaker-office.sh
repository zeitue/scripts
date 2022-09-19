#!/bin/bash

echo "Installing SoftMaker Office"

wget -qO - https://shop.softmaker.com/repo/linux-repo-public.key |\
    gpg --dearmor |\
    sudo dd status=none of=/etc/apt/trusted.gpg.d/softmaker.gpg
echo "deb https://shop.softmaker.com/repo/apt stable non-free" |\
    sudo dd status=none of=/etc/apt/sources.list.d/softmaker.list

sudo apt update
sudo apt install -y softmaker-office-2021

