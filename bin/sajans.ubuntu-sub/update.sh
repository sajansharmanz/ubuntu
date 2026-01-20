#!/bin/bash

CHOICES=(
	"Sajans Ubuntu Update Sajans ubuntu itself and run any migrations"
	"System        Update the system packages (apt update & upgrade)"
	"LazyGit       TUI for Git"
	"LazyDocker    TUI for Docker"
	"<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Update applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
	# Don't update anything
	echo ""
else
	INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

	case "$INSTALLER" in
	"sajans-ubuntu") INSTALLER_FILE="$SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/migrate.sh" ;;
  "system") INSTALLER_FILE="$SAJANS_UBUNTU_PATH/install/update/system-packages-update.sh";;
	*) INSTALLER_FILE="$SAJANS_UBUNTU_PATH/install/terminal/app-$INSTALLER.sh" ;;
	esac

	bash $INSTALLER_FILE && gum spin --spinner globe --title "Update completed!" -- sleep 3
fi

clear
source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu