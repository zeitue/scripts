#!/bin/bash

echo "Installing Zoom"
wget -c https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm ./zoom_amd64.deb


