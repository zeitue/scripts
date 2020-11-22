#!/bin/bash

# WoeUSB

echo "Installing WoeUSB"

# Add repository
sudo add-apt-repository -y ppa:tomtomtom/woeusb

sudo apt update

# Install WoeUSB
sudo apt install -y woeusb

