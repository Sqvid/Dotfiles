#!/bin/bash

LOCKSCRIPT="${HOME}/.config/sway/swayscripts/swaylock/blurlocker.sh"

response=$(echo -e "Cancel\n1. Shutdown\n2. Restart\n3. Sleep" | tofi)

if [ "$response" == "1. Shutdown" ]; then
	sudo poweroff now
elif [ "$response" == "2. Restart" ]; then
	sudo reboot now
elif [ "$response" == "3. Sleep" ]; then
	loginctl suspend
else
	exit 0
fi
