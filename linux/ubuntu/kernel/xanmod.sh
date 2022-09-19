#!/bin/bash

echo "Installing XanMod Kernel"
wget -c "https://dl.xanmod.org/xanmod-repository.deb"
sudo apt install -y "./xanmod-repository.deb"
rm "./xanmod-repository.deb"
sudo apt update
sudo apt -y install linux-xanmod

# Add background
sudo wget -c "https://xanmod.org/_media/xanmod_wallpaper.png" -P /usr/share/backgrounds/
