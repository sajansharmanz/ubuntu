#!/bin/bash

if [[ -v SAJANS_UBUNTU_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$SAJANS_UBUNTU_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			# Normalize: replace spaces with dashes and lowercase
			normalized_app=$(echo "$app" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

			source "$SAJANS_UBUNTU_PATH/install/desktop/optional/app-$normalized_app.sh"
		done
	fi
fi
