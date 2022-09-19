#!/bin/bash

echo "Installing GitFiend"
ITEM=$(
	curl "https://gitfiend.com/output/index.js" |\
	grep -o -P '(?<=href\:\"\.).*?(?=\"\,download)' |\
	grep deb
)
URL="https://gitfiend.com${ITEM}"
FILENAME=$(basename $URL)
wget -c "$URL"
sudo apt install -y "./$FILENAME"
rm "./$FILENAME"
