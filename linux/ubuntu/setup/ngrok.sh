#!/bin/bash

echo "Installing ngrok"
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc |\
 sudo dd status=none of=/etc/apt/trusted.gpg.d/ngrok.asc

echo "deb https://ngrok-agent.s3.amazonaws.com buster main" |\
 sudo dd status=none of=/etc/apt/sources.list.d/ngrok.list

sudo apt update
sudo apt install -y ngrok
