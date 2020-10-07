#!/bin/bash

function make_dir_if() {
    if [[ ! -d "$1" && ! -f "$1" ]]; then
        sudo mkdir -p "$1"
    fi
}


function make_link_if() {
    if [[ ! -h "$2" && ! -d "$2" && ! -f "$2" ]]; then
        sudo ln -s "$1" "$2"
    fi
}

# Setup /usr/local
make_dir_if /usr/local
make_dir_if /usr/local/bin
make_dir_if /usr/local/sbin
make_dir_if /usr/local/games
make_dir_if /usr/local/etc
make_dir_if /usr/local/include
make_dir_if /usr/local/src
make_dir_if /usr/local/lib
make_dir_if /usr/local/lib32
make_dir_if /usr/local/lib64
make_dir_if /usr/local/libexec
make_dir_if /usr/local/share
make_dir_if /usr/local/share/man
make_dir_if /usr/local/share/doc
make_dir_if /usr/local/share/info
make_dir_if /usr/local/share/pixmaps
make_dir_if /usr/local/share/applications
make_dir_if /usr/local/share/icons

# Add links
cd /usr/local
make_link_if share/man man
make_link_if share/doc doc
make_link_if share/info info
cd $OLDPWD

