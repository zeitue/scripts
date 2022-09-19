#!/bin/bash

echo "Installing Webex desktop"

wget -c "https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb"
sudo apt install -y ./Webex.deb
rm ./Webex.deb
