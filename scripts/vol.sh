#!/bin/bash

vol_display () {
	local vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
	local mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

	if [[ $mute == "[MUTED]" ]]; then
		dunstify -a volume -i audio-volume-muted "VOLUME:" "\nMUTED"
	else
		dunstify -a volume -h int:value:$vol -i audio-volume-medium "VOLUME:"
	fi
}

vol_up () {
	wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ &&
		vol_display
}

vol_down () {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- &&
		vol_display
}

vol_mute () {
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &&
		vol_display
}

if [[ $1 == "up" ]]; then
	vol_up
elif [[ $1 == "down" ]]; then
	vol_down
elif [[ $1 == "mute" ]]; then
	vol_mute
else
	echo "usage: vol.sh [up/down/mute]"
fi
