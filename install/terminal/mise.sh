#!/bin/bash

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo apt-get update -y && sudo apt-get install -y gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt-get update -y
sudo apt-get install -y mise

# Install required mise packages
mise use -g node@latest python@latest aws-cli aws-sam
sleep 3

source ~/.bashrc
pip install --user pipx
sleep 3
mise use -g awsebcli

pip install awscli

mise use java@openjdk-21 java@openjdk-17 gradle@7.4.2
mise use -g npm:aws-cdk npm:sfw