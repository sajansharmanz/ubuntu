#!/bin/bash

# Needed for all installers
sudo apt-get update -y
sudo apt-get upgrade -y --allow-downgrades
sudo apt-get install -y curl git unzip

# Run terminal installers
for installer in ~/.local/share/sajans.ubuntu/install/terminal/*.sh; do
  source $installer;
done