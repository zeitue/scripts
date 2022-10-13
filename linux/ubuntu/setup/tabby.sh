#!/bin/bash

getLatest() {
  REPO=$1
  SUFFIX=$2
  PREFIX=$3
  curl --silent https://api.github.com/repos/$REPO/releases/latest | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(''.join(s['browser_download_url']
for s in x['assets'] if s['name'].endswith('$SUFFIX')))"
}

echo "Installing Tabby"
URL=$(getLatest Eugeny/tabby linux-x64.deb)
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"

