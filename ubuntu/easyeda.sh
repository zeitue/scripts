#!/bin/bash

# EasyEDA
VERSION=6.4.7
wget -c "https://image.easyeda.com/files/easyeda-linux-x64-$VERSION.zip"
unzip "easyeda-linux-x64-$VERSION.zip" -d easyeda
chmod +x ./easyeda/install.sh
sudo ./easyeda/install.sh
rm -Rf easyeda
rm "easyeda-linux-x64-$VERSION.zip"
