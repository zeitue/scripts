#!/bin/bash

echo "Installing RStudio"

sudo apt install -y r-base build-essential

URL=$(
    curl "https://www.rstudio.com/products/rstudio/download/#download" |\
    grep "amd64\.deb" |\
    sed -n 's:.*href="\(.*\)">.*:\1:p' |\
    cut -d\" -f1 |\
    grep `lsb_release -c | cut -f 2`
)

FILENAME=$(basename "$URL")
wget -c "$URL"
sudo apt install -y "./${FILENAME}"
rm "${FILENAME}"

