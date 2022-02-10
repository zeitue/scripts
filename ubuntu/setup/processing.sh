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
for s in x['assets'] if s['name'].endswith('$SUFFIX')))"
}

URL=$(getLatest processing/processing4 x64.tgz)
ANAME=$(echo $URL | sed 's:.*/::')
FNAME=${ANAME%.*}

echo "Installing Processing"
wget -c $URL
tar -xf $ANAME
sudo mv $FNAME /opt/processing
sudo sh /opt/processing/install.sh
sudo ln -s /opt/processing/processing /usr/local/bin/
sudo chown -R root:root /opt/processing
rm $ANAME

