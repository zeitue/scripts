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
for s in x['assets'] if s['name'].endswith('$SUFFIX') and s['name'].startswith('$PREFIX')))"
}

echo "Installing lsd command"
URL=$(getLatest Peltoche/lsd amd64.deb lsd_)
FNAME=$(echo $URL | sed 's:.*/::')
wget -c $URL
sudo apt install -y ./$FNAME
rm $FNAME




