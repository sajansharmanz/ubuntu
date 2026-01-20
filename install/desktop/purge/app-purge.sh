#!/bin/bash

# List of default Ubuntu apps to remove
apps=(
    "libreoffice*"
    "rhythmbox"
    "transmission*"
    "remmina"
    "cheese"
    "gnome-mahjongg"
    "gnome-mines"
    "gnome-sudoku"
    "thunderbird"
    "totem"
    "simple-scan"
    "aisleriot"
    "deja-dup"
    "evolution"
)

for app in "${apps[@]}"; do
    sudo apt-get purge -y $app
done

sudo apt-get autoremove -y
sudo apt-get autoclean -y