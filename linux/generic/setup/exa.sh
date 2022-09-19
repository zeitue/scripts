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
for s in x['assets'] if s['name'].startswith('$PREFIX') and s['name'].endswith('$SUFFIX')))"
}

echo "Installing exa"
PREVIOUS=$(pwd)
mkdir tmp_exa
cd tmp_exa
URL=$(getLatest ogham/exa exa-linux-x86_64-v zip)
FILENAME=$(basename "$URL")
wget -c "$URL"
unzip "$FILENAME"
sudo install -DT ./bin/exa /usr/local/bin/exa
sudo install -DT ./man/exa.1 /usr/local/share/man/man1/exa.1
sudo install -DT ./man/exa_colors.5 /usr/local/share/man/man5/exa_colors.5
sudo install -DT ./completions/exa.bash /etc/bash_completion.d/exa
sudo install -DT ./completions/exa.fish /etc/fish/completions/exa.fish
sudo install -DT ./completions/exa.zsh /usr/local/share/zsh/site-functions/_exa
cd "$PREVIOUS"
rm -Rf tmp_exa
