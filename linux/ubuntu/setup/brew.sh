#!/bin/bash

echo "Installing Brew"
sudo apt -y install build-essential procps curl file git

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# remove shell integration to move it globally
sed -i '/eval "$(\/home\/linuxbrew\/.linuxbrew\/bin\/brew shellenv)"/d' ~/.bash_profile

# Add into path
cat <<EOF | sudo dd status=none of="/etc/profile.d/brew.sh"
eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
EOF

