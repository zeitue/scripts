#!/bin/bash



echo "Download Davinci Resolve to your ~/Downloads directory"
echo -n "Press enter to open a web browser: "
read
xdg-open https://www.blackmagicdesign.com/products/davinciresolve/

echo -n "When the download is finished press enter: "
read
echo "Making Davinci Resolve Package"
sudo apt-get install -y fakeroot xorriso

mkdir /tmp/davinci-resolve
cd /tmp/davinci-resolve
URL_PATH=$(curl https://www.danieltufvesson.com/makeresolvedeb |\
           grep "href=\"/download" |\
           grep -o '>.*</a>' |\
           sed -n 's:.*href="\(.*\)">.*:\1:p' |\
           head -n1)
URL="https://www.danieltufvesson.com${URL_PATH}"
wget -c --content-disposition "$URL"
tar -xf *_multi.sh.tar.gz
chmod +x ./*multi.sh
unzip ~/Downloads/DaVinci_Resolve_*_Linux.zip
./makeresolvedeb_*_multi.sh DaVinci_Resolve_*_Linux.run
echo "Installing Davinci Resolve"
sudo apt install -y ./davinci-resolve*.deb
cd
rm -Rf /tmp/davinci-resolve

