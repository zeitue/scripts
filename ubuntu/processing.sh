#!/bin/bash

# Processing
VERSION=3.5.4

echo "Installing Processing ${VERSION}"
wget "https://download.processing.org/processing-${VERSION}-linux64.tgz"
tar -xf "processing-${VERSION}-linux64.tgz"
sudo mv "processing-${VERSION}" /opt/processing
sudo sh /opt/processing/install.sh
sudo ln -s /opt/processing/processing /usr/local/bin/
sudo chown -R root:root /opt/processing
rm "processing-${VERSION}-linux64.tgz"
