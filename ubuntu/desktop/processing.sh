#!/bin/bash

# Processing
VERSION=4.0b2

echo "Installing Processing ${VERSION}"
wget -c "https://github.com/processing/processing4/releases/download/processing-1277-${VERSION}/processing-${VERSION}-linux64.tgz"
tar -xf "processing-${VERSION}-linux64.tgz"
sudo mv "processing-${VERSION}" /opt/processing
sudo sh /opt/processing/install.sh
sudo ln -s /opt/processing/processing /usr/local/bin/
sudo chown -R root:root /opt/processing
rm "processing-${VERSION}-linux64.tgz"
