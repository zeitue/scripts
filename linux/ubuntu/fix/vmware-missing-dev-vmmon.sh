#!/bin/bash

echo "Fixing: could not open /dev/vmmon: No such file or directory"
sudo vmware-modconfig --console --install-all

