#!/bin/bash

# setup flatpak
sudo apt install -y flatpak flatpak-xdg-utils
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

