#!/bin/bash

image=/tmp/$(mktemp -u XXXXXXXX_screenlock.png)
blur=0x20

grim $image
convert $image -blur $blur $image
swaylock --image $image
rm $image

exit 0
