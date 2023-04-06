#!/bin/bash

echo "Installing VariCAD"

PAGE=$(curl "https://www.varicad.com/en/home/products/download/")
APP=$(
    echo "$PAGE" |\
    grep -io 'href=['"'"'"][^"'"'"']*['"'"'"]' |\
    sed -e 's/^href=["'"'"']//i' -e 's/["'"'"']$//i' |\
    grep deb | head -n1
)

VIEWER=$(
    echo "$PAGE" |\
    grep -io 'href=['"'"'"][^"'"'"']*['"'"'"]' |\
    sed -e 's/^href=["'"'"']//i' -e 's/["'"'"']$//i' |\
    grep deb | tail -n1
)

APP_URL="https://www.varicad.com/$APP"
VIEWER_URL="https://www.varicad.com/$VIEWER"

mkdir varicad_tmp
cd varicad_tmp

wget -c "$APP_URL"
wget -c "$VIEWER_URL"

sudo apt install -y ./*.deb
cd ..
rm -Rf varicad_tmp
