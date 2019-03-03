#!/bin/bash

bgimage="${HOME}/.config/sway/swaylock/PolygonI.png"

textcolor=ffffff
keyhlcolor=00eddd98
bshlcolor=680000
linecolor=00000000
separatorcolor=00000000

insidecolor=ffffff1a
ringcolor=0000001a

insidevercolor=0000001a
ringvercolor=ffffff1a

insidewrongcolor=680000
ringwrongcolor=680000

indicatorradius=80
indicatorthickness=7

swaylock -f -i $bgimage --scaling fill\
	--textcolor $textcolor \
	--keyhlcolor $keyhlcolor \
	--bshlcolor $bshlcolor \
	--linecolor $linecolor \
	--separatorcolor $separatorcolor \
	--insidecolor $insidecolor \
	--ringcolor $ringcolor \
	--insidevercolor $insidevercolor \
	--ringvercolor $ringvercolor \
	--insidewrongcolor $insidewrongcolor \
	--ringwrongcolor $ringwrongcolor \
	--indicator-radius $indicatorradius \
	--indicator-thickness $indicatorthickness
