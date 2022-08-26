#!/bin/bash

echo "Installing Grub Customizer"

sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install -y grub-customizer
