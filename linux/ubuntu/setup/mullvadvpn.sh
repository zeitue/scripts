#!/bin/bash

echo "Installing Mullvad VPN"

mkdir tmp
cd tmp
wget -c --content-disposition https://mullvad.net/download/app/deb/latest/

sudo apt install -y ./*.deb
cd ../
rm -Rf tmp

