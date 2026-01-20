#!/bin/bash

THEME_NAMES=("Monochrome")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  if [ -f "$SAJANS_UBUNTU_PATH/themes/$THEME/btop.theme" ]; then
    cp $SAJANS_UBUNTU_PATH/themes/$THEME/btop.theme ~/.config/btop/themes/$THEME.theme
    sed -i "s/color_theme = \".*\"/color_theme = \"$THEME\"/g" ~/.config/btop/btop.conf
  else
    sed -i "s/color_theme = \".*\"/color_theme = \"Default\"/g" ~/.config/btop/btop.conf
  fi

  source $SAJANS_UBUNTU_PATH/themes/$THEME/gnome.sh
  source $SAJANS_UBUNTU_PATH/themes/$THEME/tophat.sh
  source $SAJANS_UBUNTU_PATH/themes/$THEME/vscode.sh
fi

source $SAJANS_UBUNTU_PATH/bin/sajans.ubuntu-sub/menu.sh