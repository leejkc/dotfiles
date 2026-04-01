#!/bin/bash

display () {
	local ico=preferences-system-power-symbolic
	local ppd=$(powerprofilesctl get)

	dunstify -a power -i $ico "SETTING POWER MODE:" "$(echo ${ppd^^})"
}

yambar () {
	while true; do
		local ppd=$(powerprofilesctl get)

		echo "ppd|string|$ppd"
		echo ""
		sleep 3
	done
}

if [[ $1 == "bal" ]]; then
	powerprofilesctl set balanced &&
		display
elif [[ $1 == "sav" ]]; then
	powerprofilesctl set power-saver &&
		display
elif [[ $1 == "per" ]]; then
	powerprofilesctl set performance &&
		display
elif [[ $1 == "bar" ]]; then
	yambar
else
	echo "usage: [bal/sav/per/bar]"
fi
