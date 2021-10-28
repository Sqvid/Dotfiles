#!/bin/bash

LOCKSCRIPT="${HOME}/.config/sway/swayscripts/swaylock/blurlocker.sh"

response=$(echo -e "Cancel\n1. Shutdown\n2. Restart\n3. Sleep" | \
	rofi -config ~/.config/rofi/config -dmenu -p "Power Options")

if [ "$response" == "1. Shutdown" ]; then
	sudo poweroff now
elif [ "$response" == "2. Restart" ]; then
	sudo reboot now
elif [ "$response" == "3. Sleep" ]; then
	echo "Unimplemented"
	#loginctl suspend
else
	exit 0
fi
