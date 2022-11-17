# Zsh login shell configuration.

# Window Manager:
if [[ "${TTY}" == "/dev/tty1" ]]; then
	echo "Launching Sway..."
	# Give the user time to cancel.
	sleep 2

	# Set environment variables.
	export BROWSER=$(which firefox-wayland)
	export WM=sway

	exec dbus-run-session sway --unsupported-gpu
fi
