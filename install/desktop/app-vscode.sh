#!/bin/bash

cd /tmp
# Install signing key
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

# Add upstream package repository
sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
cd -

# Install code
sudo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo apt-get install -y code

mkdir -p ~/.config/Code/User
cp ~/.local/share/sajans.ubuntu/configs/vscode.jsonc ~/.config/Code/User/settings.json

# Install default plugins and theme
extensions=(
  "viktorqvarfordt.vscode-pitch-black-theme"
  "PKief.material-icon-theme"
  "dbaeumer.vscode-eslint"
  "esbenp.prettier-vscode"
  "YoavBls.pretty-ts-errors"
  "bradlc.vscode-tailwindcss"
  "redhat.vscode-yaml"
  "tamasfe.even-better-toml"
  "christian-kohler.npm-intellisense"
)

# Loop through and install each extension if not already exists
for ext in "${extensions[@]}"; do
    if code --list-extensions | grep -q "^$ext$"; then
        echo "Extension '$ext' is already installed, skipping."
    else
        code --install-extension "$ext"
    fi
done

