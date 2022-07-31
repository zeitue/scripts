#!/bin/bash

echo "Installing App Outlet"

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

URL=$(getLatest app-outlet/app-outlet amd64.deb)
FILENAME=$(basename "$URL")
wget -c "$URL"

sudo apt install -y "./$FILENAME"
rm "./$FILENAME"

# fix electron issue
sudo sed -i 's/%U$/%U --disable-seccomp-filter-sandbox/g' /usr/share/applications/app-outlet.desktop
