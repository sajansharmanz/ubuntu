#!/bin/bash

# Only ask for default desktop app choices when running Gnome
DESKTOP=${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-}}

if [[ "$DESKTOP" == *"GNOME"* ]]; then
  OPTIONAL_APPS=(
    "Postman"
    "Whatsapp"
    "Signal"
    "Spotify"
    "LibreOffice"
    "Remmina"
    "Youtube Music"
    "Notion"
  )

  DEFAULT_OPTIONAL_APPS=""

  export SAJANS_UBUNTU_FIRST_RUN_OPTIONAL_APPS=$(
    gum choose "${OPTIONAL_APPS[@]}" \
      --no-limit \
      --selected "$DEFAULT_OPTIONAL_APPS" \
      --height 7 \
      --header "Select optional apps" \
    | tr ' ' '-'
  )
fi
