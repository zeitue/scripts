#!/bin/bash

# EasyEDA

echo "Installing EasyEDA"
VERSION=6.4.7
wget -c "https://image.easyeda.com/files/easyeda-linux-x64-$VERSION.zip"
unzip "easyeda-linux-x64-$VERSION.zip" -d easyeda
cd easyeda
chmod +x ./install.sh
sudo ./install.sh
cd ..
rm -Rf easyeda
rm "easyeda-linux-x64-$VERSION.zip"
