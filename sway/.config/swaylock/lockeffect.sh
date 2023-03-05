#!/bin/bash

image=/tmp/$(mktemp -u XXXXXXXX_screenlock.png)

# Take a screenshot.
grim ${image}

# Apply effect.
convert ${image} -interpolate nearest -spread 10 -blur 0x2 ${image}

# Lock the screen.
swaylock --image ${image}

# Clean up.
rm ${image}

exit 0
