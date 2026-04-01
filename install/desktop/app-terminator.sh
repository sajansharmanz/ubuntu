#!/bin/bash

# Install terminator
sudo apt-get install -y terminator curl unzip

# Install Hack Nerd Font
mkdir -p ~/.local/share/fonts
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -o Hack.zip -d ~/.local/share/fonts
fc-cache -fv

# Create Terminator config directory
mkdir -p ~/.config/terminator

# Write config
cat > ~/.config/terminator/config <<EOF
[global_config]
  focus = system

[profiles]
  [[default]]
    use_system_font = False
    font = Hack Nerd Font Mono 11
EOF

echo "Done. Restart Terminator."