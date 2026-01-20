#!/bin/bash

# Favorite apps for dock
apps=(
    "google-chrome.desktop"
    "ghostty_ghostty.desktop"
    "code.desktop"
    "Activity.desktop"
    "Docker.desktop"
    "SajansUbuntu.desktop"
    "org.gnome.Settings.desktop"
    "org.gnome.Nautilus.desktop"
)

# Apps to optionally move after code.desktop if they exist
optional_after_code=(
    "postman_postman.desktop"
    "spotify.desktop"
    "WhatsApp.desktop"
    "YoutubeMusic.desktop"
    "Notion.desktop"
)

# Array to hold installed favorite apps
installed_apps=()

# Directory where .desktop files are typically stored
desktop_dirs=(
    "/var/lib/flatpak/exports/share/applications"
    "/var/lib/snapd/desktop/applications"
    "/usr/share/applications"
    "/usr/local/share/applications"
    "$HOME/.local/share/applications"
)

# Check if a .desktop file exists for each app in the main list
for app in "${apps[@]}"; do
    for dir in "${desktop_dirs[@]}"; do
        if [ -f "$dir/$app" ]; then
            installed_apps+=("$app")
            break
        fi
    done
done

# Insert optional apps after code.desktop if they exist
final_apps=()
for app in "${installed_apps[@]}"; do
    final_apps+=("$app")
    if [ "$app" == "code.desktop" ]; then
        for opt_app in "${optional_after_code[@]}"; do
            # Check if optional app exists in any desktop dir
            for dir in "${desktop_dirs[@]}"; do
                if [ -f "$dir/$opt_app" ]; then
                    final_apps+=("$opt_app")
                    break
                fi
            done
        done
    fi
done

# Convert the array to a format suitable for gsettings
favorites_list=$(printf "'%s'," "${final_apps[@]}")
favorites_list="[${favorites_list%,}]"

# Set the favorite apps
gsettings set org.gnome.shell favorite-apps "$favorites_list"