#!/bin/bash

# Install remote access via ssh
sudo apt install -y openssh-server openssh-sftp-server sshfs

# Enable sshd
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow OpenSSH

# Allow all users to mount FUSE file systems
sudo sed -i '/user_allow_other/s/^#//g' /etc/fuse.conf
