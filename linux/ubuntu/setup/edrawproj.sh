#!/bin/bash

echo "Installing EdrawProj"

URL=$(
  curl "https://www.edrawsoft.com/download-edrawproject.html" |
  grep -io 'href=['"'"'"][^"'"'"']*['"'"'"]' |\
  sed -e 's/^href=["'"'"']//i' -e 's/["'"'"']$//i' |\
  grep deb |\
  head -n1
)
FILENAME=$(basename $URL)
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
