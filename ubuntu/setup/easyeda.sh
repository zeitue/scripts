#!/bin/bash

# EasyEDA

echo "Installing EasyEDA"

URL=$(curl https://easyeda.com/page/download |\
      grep easyeda-linux |\
      sed 's/.*=//' |\
      tr -d \")
FNAME=$(echo $URL | sed 's:.*/::')

wget -c $URL
unzip $FNAME -d easyeda
cd easyeda
chmod +x ./install.sh
sudo ./install.sh
cd ..
rm -Rf easyeda
rm $FNAME

