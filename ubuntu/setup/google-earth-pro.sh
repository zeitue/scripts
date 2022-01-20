#!/bin/bash

echo "Installing Google Earth Pro"

wget -c https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
sudo apt -y install ./google-earth-pro-stable_current_amd64.deb
rm ./google-earth-pro-stable_current_amd64.deb


