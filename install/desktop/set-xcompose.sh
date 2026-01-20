#!/bin/bash

envsubst < ~/.local/share/sajans.ubuntu/configs/xcompose > ~/.XCompose
ibus restart
gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"