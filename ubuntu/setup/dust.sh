#!/bin/bash

getLatest() {
  REPO=$1
  PREFIX=$2
  SUFFIX=$3
  curl --silent https://api.github.com/repos/$REPO/releases/latest | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(''.join(s['browser_download_url']
for s in x['assets'] if s['name'].endswith('$SUFFIX') and s['name'].startswith('$PREFIX')))"
}

echo "Installing dust command"
URL=$(getLatest bootandy/dust du-dust_ _amd64.deb)
FILENAME=$(basename "$URL")
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "$FILENAME"

