#!/bin/bash



echo "Installing LunarG Vulkan SDK"

wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc |\
    sudo dd status=none of="/etc/apt/trusted.gpg.d/lunarg.asc"
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list \
    https://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
sudo apt update
sudo apt install -y vulkan-sdk
