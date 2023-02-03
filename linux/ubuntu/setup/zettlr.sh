#!/bin/bash
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



echo "Installing Zettlr"

URL=$(getLatest "Zettlr/Zettlr" amd64.deb)
FILE=$(basename "$URL")
wget -c "$URL"
rm ./$FILE
