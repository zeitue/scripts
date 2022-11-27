#!/bin/bash

echo "Installing Lychee Slicer"

URL=$(
  curl "https://mango3d.io/downloads/" |
  grep -io 'href=['"'"'"][^"'"'"']*['"'"'"]' |\
  sed -e 's/^href=["'"'"']//i' -e 's/["'"'"']$//i' |\
  grep deb |\
  head -n1
)
FILENAME=$(basename $URL)
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
