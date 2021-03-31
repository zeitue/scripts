#!/bin/bash

# setup flatpak
echo "Installing Flatpak"
sudo apt install -y flatpak flatpak-xdg-utils
echo "Adding Flathub repository"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
