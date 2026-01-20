#!/bin/bash

# This script installs btop, a resource monitor that shows usage and stats for processor, memory, disks, network and processes.
sudo apt-get install -y btop

# Use sajans btop config
mkdir -p ~/.config/btop/themes
cp ~/.local/share/sajans.ubuntu/configs/btop.conf ~/.config/btop/btop.conf
cp ~/.local/share/sajans.ubuntu/themes/monochrome/btop.theme ~/.config/btop/themes/monochrome.theme