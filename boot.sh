#!/bin/bash

set -e

ascii_art='
███████  █████       ██  █████  ███    ██ ███████     ██    ██ ██████  ██    ██ ███    ██ ████████ ██    ██
██      ██   ██      ██ ██   ██ ████   ██ ██          ██    ██ ██   ██ ██    ██ ████   ██    ██    ██    ██
███████ ███████      ██ ███████ ██ ██  ██ ███████     ██    ██ ██████  ██    ██ ██ ██  ██    ██    ██    ██
     ██ ██   ██ ██   ██ ██   ██ ██  ██ ██      ██     ██    ██ ██   ██ ██    ██ ██  ██ ██    ██    ██    ██
███████ ██   ██  █████  ██   ██ ██   ████ ███████      ██████  ██████   ██████  ██   ████    ██     ██████
'


echo "$ascii_art"
echo "This is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)...\n"

sudo apt-get update -y 2>/dev/null
sudo apt-get install -y curl wget git 2>/dev/null

echo "Cloning Sajan's Ubuntu Setup..."
rm -rf ~/.local/share/sajans.ubuntu
git clone 'https://github.com/sajansharmanz/ubuntu.git' ~/.local/share/sajans.ubuntu 2>/dev/null
if [[ $SAJANS_UBUNTU_SETUP_REF != "development" ]]; then
	cd ~/.local/share/sajans.ubuntu
	git fetch origin "${SAJANS_UBUNTU_SETUP_REF:-main}" && git checkout "${SAJANS_UBUNTU_SETUP_REF:-main}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/sajans.ubuntu/install.sh