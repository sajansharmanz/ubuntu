#!/bin/bash

sudo apt-add-repository ppa:remmina-ppa-team/remmina-next -y
sudo apt-get update -y
sudo apt-get install remmina remmina-plugin-rdp remmina-plugin-secret -y

cd ~