#!/bin/bash


echo "Installing AmScopeAmLite"

wget -c https://storage.googleapis.com/software-download-d79bb.appspot.com/software/AmLite/Linux/20210304/AmScopeAmLite.x64.tar.bz2
tar -xf AmScopeAmLite.x64.tar.bz2
sudo ./AmScopeAmLite.x64.sh
sudo mv /root/Desktop/AmLite.desktop /usr/local/share/applications/
rm ./AmScopeAmLite.x64.sh ./AmScopeAmLite.x64.tar.bz2
