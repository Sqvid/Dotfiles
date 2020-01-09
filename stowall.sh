#!/bin/bash

if [[ $# != 1 ]]; then
	echo "Provide -s or -d switch"
	exit -1
fi

for item in $(ls ~/.Dotfiles/)
do
	if [[ -d $item ]]; then
		if [[ $1 == '-s' ]]; then
			stow -v $item
		elif [[ $1 == '-d' ]]; then
			stow -vD $item
		else
			echo "Unknown option"
			exit -2
		fi
	fi
done

exit
