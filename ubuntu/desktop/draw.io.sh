#!/bin/bash

wget -c "https://github.com/jgraph/drawio-desktop/releases/download/v15.4.0/drawio-amd64-15.4.0.deb"
sudo apt install -y ./drawio-amd64-15.4.0.deb
rm ./drawio-amd64-15.4.0.deb

