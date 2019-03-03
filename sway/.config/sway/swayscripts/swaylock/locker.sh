#!/bin/bash

bgimage=$1

textcolor=ffffff
keyhlcolor=07948a
bshlcolor=680000
linecolor=000000ff
linevercolor=000000ff
linewrongcolor=000000ff
lineclearcolor=000000ff
separatorcolor=00000000

insidecolor=0000001a
ringcolor=ffffff1a

insidevercolor=0000001a
ringvercolor=ffffff1a

insidewrongcolor=680000
ringwrongcolor=680000

insideclearcolor=$keyhlcolor
ringclearcolor=$keyhlcolor

indicatorradius=95
indicatorthickness=7

swaylock -f -i $bgimage --scaling fill\
	--text-color $textcolor \
	--text-ver-color $textcolor \
	--text-wrong-color $textcolor \
	--text-clear-color $textcolor \
	--key-hl-color $keyhlcolor \
	--bs-hl-color $bshlcolor \
	--line-uses-inside \
	--separator-color $separatorcolor \
	--inside-color $insidecolor \
	--ring-color $ringcolor \
	--inside-ver-color $insidevercolor \
	--ring-ver-color $ringvercolor \
	--inside-wrong-color $insidewrongcolor \
	--inside-clear-color $keyhlcolor \
	--ring-clear-color $keyhlcolor \
	--ring-wrong-color $ringwrongcolor \
	--indicator-radius $indicatorradius \
	--indicator-thickness $indicatorthickness
