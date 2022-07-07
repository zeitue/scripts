#!/bin/bash

echo "Installing Wavebox"
mkdir ./tmp
wget --content-disposition \
     -c https://download.wavebox.app/latest/stable/linux/deb \
     -P ./tmp
sudo apt install -y ./tmp/*.deb
rm -Rf ./tmp


