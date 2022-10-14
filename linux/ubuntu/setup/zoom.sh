#!/bin/bash

install_zoom() {
    wget -c https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install -y ./zoom_amd64.deb
    rm ./zoom_amd64.deb
    echo "Installing Zoom"
}

vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}


current=0.0.0.0
if [[ -f "/opt/zoom/version.txt" ]]
then
    current=$(cat /opt/zoom/version.txt)
    available=$(wget --spider https://zoom.us/client/latest/zoom_amd64.deb 2>&1 | grep Location | sed -e 's/.*prod\/\(.*\)\/.*/\1/')
    vercomp $current $available
    case $? in
        0) echo "Nothing to do";;
        1) echo "Won't downgrade";;
        2) install_zoom;;
    esac
else
    install_zoom
fi

