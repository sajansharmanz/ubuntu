#!/bin/bash

sudo apt-get install -y flatpak
sudo apt-get install -y gnome-software-plugin-flatpak

if ! flatpak remotes | grep -q flathub; then
  sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
fi
