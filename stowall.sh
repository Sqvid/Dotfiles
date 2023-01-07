#!/bin/sh

if [ $# != 1 ]; then
	echo "Provide -s or -d switch"
	exit 1
fi

if [ "${PWD}" != "{HOME}/.Dotfiles" ]; then
	echo "Please place this file in ${HOME}/.Dotfiles"
fi

for item in *
do
	if [ -d "${item}" ]; then
		if [ "$1" = "-s" ]; then
			stow -v "${item}"
		elif [ "$1" = "-d" ]; then
			stow -vD "${item}"
		else
			echo "Provide -s or -d switch"
			exit 2
		fi
	fi
done

exit
