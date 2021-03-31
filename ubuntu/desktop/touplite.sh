#!/bin/bash

# ToupLite

echo "Installing ToupLite"

wget -c http://www.touptek.com//upload/download/ToupTekToupLite.x64.tar.bz2
tar -xf ToupTekToupLite.x64.tar.bz2
sudo ./ToupTekToupLite.x64.sh
sudo mv /root/Desktop/ToupLite.desktop /usr/local/share/applications/
sudo rm ./ToupTekToupLite.x64.sh ./ToupTekToupLite.x64.tar.bz2
