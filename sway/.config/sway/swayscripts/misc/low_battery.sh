#!/bin/bash

state=$(acpi -b | cut -d ' ' -f 3)
dietime=$(acpi -b | cut -d ' ' -f 5)
critical="00:20:00"

if [[ $state = "Discharging," && $dietime < $critical ]]; then
	notify-send "Low battery! Please charge now."
fi

exit 0
