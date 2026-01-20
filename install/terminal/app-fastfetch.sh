#!/bin/bash

# Display system information in the terminal
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt-get update -y
sudo apt-get install -y fastfetch

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Sajans fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/sajans.ubuntu/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi