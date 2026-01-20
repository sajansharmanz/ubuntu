#!/bin/bash

if [ $# -eq 0 ]; then
	SUB=$(gum choose "Install" "Update" "Manual" "Theme" "Backup" "Restore" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

[ -n "$SUB" ] && [ "$SUB" != "quit" ] && source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/$SUB.sh