#!/bin/bash

echo "Fixing delayed sound issue"
sudo sed -i '/load-module module-suspend-on-idle/s/^#*/#/g' \
            /etc/pulse/default.pa
