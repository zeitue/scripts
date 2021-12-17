#!/bin/bash

# Bash

sudo apt install -y bash git wget

# Oh My Bash

bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

sed -i -e 's/font/pure/g' ~/.bashrc
sed -i -e 's/OSH=.*$/OSH=\"$HOME\/.oh-my-bash\"/g' ~/.bashrc
sudo cp -R ~/.oh-my-bash /etc/skel/
sudo cp ~/.bashrc /etc/skel/

