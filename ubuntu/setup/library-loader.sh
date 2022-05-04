#!/bin/bash

getLatest() {
  REPO=$1
  SUFFIX=$2
  curl --silent https://api.github.com/repos/$REPO/releases/latest | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(''.join(s['browser_download_url']
for s in x['assets'] if s['name'].endswith('.$SUFFIX')))"
}

echo "Installing library loader"

URL=$(getLatest olback/library-loader gz)
FILE=$(basename "$URL")
DIR=${FILE%.tar.gz}
wget -c "$URL"
tar -xf "$FILE"
cd "$DIR"
sudo ./install.sh
cd ../
rm "./$FILE"
rm -R "$DIR"

