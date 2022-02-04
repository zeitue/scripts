#!/bin/bash

echo "Installing Vivaldi browser"

URL=$(curl https://vivaldi.com/download/ |\
      sed 's/>/>\n/g' |\
      grep "amd64.deb" |\
      sed -n 's:.*href="\(.*\)">.*:\1:p' |\
      cut -d\" -f1)

FILENAME=$(basename "$URL")
wget -c "$URL"
sudo apt install -y "./${FILENAME}"
rm "${FILENAME}"

