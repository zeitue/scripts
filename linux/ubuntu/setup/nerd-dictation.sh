#!/bin/bash

echo "Installing Nerd Dictation"
sudo apt install -y pulseaudio-utils sox xdotool ydotool ydotoold \
    python3-virtualenv python3-venv

sudo python3 -m venv /opt/nerd-dictation
sudo chown -R $USER /opt/nerd-dictation
source /opt/nerd-dictation/bin/activate
pip3 install vosk
cd /opt/nerd-dictation
git clone https://github.com/ideasman42/nerd-dictation.git ./app
git clone https://github.com/papoteur-mga/elograf.git
cd elograf
python3 setup.py install
pip install ujson pyqt5

cat <<EOF | dd status=none of="/opt/nerd-dictation/bin/launch-elograf"
#!/bin/bash
source /opt/nerd-dictation/bin/activate 
elograf
EOF
chmod +x /opt/nerd-dictation/bin/launch-elograf
ln -sf /opt/nerd-dictation/app/nerd-dictation /opt/nerd-dictation/bin/nerd-dictation
sudo chown -R root /opt/nerd-dictation

cat <<EOF | sudo dd status=none of="/usr/local/share/applications/elograf.desktop"
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Elograf
GenericName=Tool to launch voice dictation
Comment=Tool in systray to launch voice dictation
Exec=/opt/nerd-dictation/bin/launch-elograf
Icon=audio-input-microphone
Terminal=false
Type=Application
Categories=Accessibility;Utility;
EOF

