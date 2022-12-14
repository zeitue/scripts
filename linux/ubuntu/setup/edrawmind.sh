#!/bin/bash

echo "Installing EdrawMind"

URL=$(
  curl "https://www.edrawsoft.com/download-edrawmind.html" |
  grep -io 'href=['"'"'"][^"'"'"']*['"'"'"]' |\
  sed -e 's/^href=["'"'"']//i' -e 's/["'"'"']$//i' |\
  grep deb |\
  head -n1
)
FILENAME=$(basename $URL)
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
