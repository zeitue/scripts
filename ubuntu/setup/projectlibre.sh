#!/bin/bash

getLatest() {
  PRJ=$1
  curl --silent https://sourceforge.net/projects/$PRJ/best_release.json | \
    python3 -c "
import sys;
from json import loads as l;
x = l(sys.stdin.read());
print(x['platform_releases']['linux']['url'])"
}

URL=$(getLatest 'projectlibre')
FILENAME=$(basename ${URL%\?*})
echo "Installing ProjectLibre"
# seems the API does not like things so quick
sleep 3
wget -c --content-disposition "$URL"
sudo apt -y install ./$FILENAME
rm ./$FILENAME

