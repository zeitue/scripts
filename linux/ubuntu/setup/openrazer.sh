#!/bin/bash

# OpenRazer

echo "Installing OpenRazer"

sudo apt install -y software-properties-gtk
sudo add-apt-repository -y ppa:openrazer/stable

sudo apt update
sudo apt install -y openrazer-meta

sudo usermod -a -G plugdev $USER

