#!/bin/bash

while true
do
	if [[ $(pgrep cmus) == "" ]]; then
		echo ""
		sleep 5
		continue
	fi

	song=$(cmus-remote -C status | grep "tag title" | cut -d ' ' -f3-)
	artist=$(cmus-remote -C status | grep "\<tag artist\>" | cut -d ' ' -f3-)

	echo "$song - $artist"
	sleep 1
done
