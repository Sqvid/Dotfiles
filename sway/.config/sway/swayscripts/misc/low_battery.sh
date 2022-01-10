#!/bin/bash

# DBUS_SESSION_BUS_ADDRESS is needed to show notifications from cron.
. "${HOME}/.dbus/sway_session"
export DBUS_SESSION_BUS_ADDRESS

state=$(acpi -b | cut -d ' ' -f 3)
dietime=$(acpi -b | cut -d ' ' -f 5)
critical="00:20:00"

if [[ ${state} = "Discharging," && ${dietime} < ${critical} ]]; then
	notify-send "Low battery! Please charge now."
fi

exit 0
