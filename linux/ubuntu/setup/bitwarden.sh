#!/bin/bash

echo "Installing Bitwarden"
URL='https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb'
PREVIOUS=$(pwd)
mkdir tmp_bitwarden
cd tmp_bitwarden
curl -JLO "$URL"
sudo apt install ./*.deb
cd "$PREVIOUS"
rm -Rf tmp_bitwarden
