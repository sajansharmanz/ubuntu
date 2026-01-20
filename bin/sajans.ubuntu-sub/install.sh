#!/bin/bash

CHOICES=(
  "LibreOffice       Install LibreOffice"
  "Postman           Install Postman"
  "Remmina           Install Remmina"
  "Spotify           Install Spotify"
  "WhatsApp          Install WhatsApp"
  "Youtube Music     Install Youtube Music"
  "> All             Re-run any of the default installers"
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 25 --header "Install application")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
elif [[ "$CHOICE" == "> All"* ]]; then
  INSTALLER_FILE=$(find "$SAJANS_UBUNTU_PATH/install/desktop" "$SAJANS_UBUNTU_PATH/install/terminal" -maxdepth 1 -type f | gum choose)

  [[ -n "$INSTALLER_FILE" ]] &&
    gum confirm "Run installer?" &&
    source $INSTALLER_FILE &&
    gum spin --spinner globe --title "Install completed!" -- sleep 3
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

  case "$INSTALLER" in
  *) INSTALLER_FILE="$SAJANS_UBUNTU_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
  esac

  source $INSTALLER_FILE && gum spin --spinner globe --title "Install completed!" -- sleep 3
fi

clear
source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu