#!/bin/bash

echo "Installing Electron App Store"

getLatest() {
  REPO=$1
  SUFFIX=$2
  curl --silent https://api.github.com/repos/$REPO/releases/latest | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(''.join(s['browser_download_url']
for s in x['assets'] if s['name'].endswith('$SUFFIX')))"
}

URL=$(getLatest Electron-Store/electron-app-store amd64.deb)
FILENAME=$(basename "$URL")
wget -c "$URL"

sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
