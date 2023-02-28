#!/bin/bash

echo "Installing Geekbench6"
URL=$(
    curl "https://www.geekbench.com/download/linux/" |\
    grep tar.gz |\
    sed -n 's:.*href="\(.*\)">.*:\1:p' |\
    head -n1
)
PREVIOUS=$(pwd)
TMP="$PREVIOUS/geekbench6_tmp"
mkdir -p "$TMP"
cd "$TMP"
FILENAME=$(basename "$URL")
T=${FILENAME#*-}
VERSION=${T%-*}
wget -c "$URL"
sudo mkdir -p "/opt/geekbench/${VERSION}"
tar -xf "./$FILENAME"
sudo cp */* /opt/geekbench/${VERSION}/
sudo ln -s /opt/geekbench/${VERSION}/geekbench? /usr/local/bin/
cd "$PREVIOUS"
rm -Rf "$TMP"
