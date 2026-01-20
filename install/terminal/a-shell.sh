#!/bin/bash

# Configure the bash shell using Sajans defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/sajans.ubuntu/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/sajans.ubuntu/defaults/bash/shell
[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak

# Configure the inputrc using Sajans defaults
cp ~/.local/share/sajans.ubuntu/configs/inputrc ~/.inputrc