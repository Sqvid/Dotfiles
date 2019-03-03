#!/bin/bash

IMAGE=/tmp/$(mktemp -u XXXXXXXX_screenlock.png)
BLUR=0x20
LOCKSCRIPT="${HOME}/.config/sway/swayscripts/swaylock/locker.sh"

grim $IMAGE
convert $IMAGE -blur $BLUR $IMAGE
$LOCKSCRIPT $IMAGE
rm $IMAGE

exit 0
