#!/bin/bash

# setup flatpak
echo "Installing Flatpak"
sudo apt install -y flatpak flatpak-xdg-utils

if [[ -f "/usr/bin/plasma-discover" ]]; then
sudo apt install -y plasma-discover-backend-flatpak
fi

if [[ -f "/usr/bin/gnome-software" ]]; then
sudo apt install -y gnome-software-plugin-flatpak
fi

echo "Adding Flathub repository"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
