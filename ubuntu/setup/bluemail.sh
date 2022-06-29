#!/bin/bash

echo "Installing BlueMail"
wget -c "https://download.bluemail.me/BlueMail/deb/BlueMail.deb"
sudo apt install ./BlueMail.deb
rm ./BlueMail.deb

