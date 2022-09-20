#!/bin/bash

echo "Installing Zoom"
# Add key
curl "https://zoom.us/linux/download/pubkey" -o zoom.pub
sudo rpm --import zoom.pub
rm zoom.pub

wget -c https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf install -y ./zoom_x86_64.rpm
rm ./zoom_x86_64.rpm


