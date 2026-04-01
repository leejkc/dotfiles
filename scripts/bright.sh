#!/bin/bash

mon_brightness_display () {
	local max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
	local cur=$(cat /sys/class/backlight/intel_backlight/brightness)
	local val=$(echo "scale=2; ($cur / $max) * 100" | bc)

	dunstify -a brightness -h int:value:$val -i brightness "LCD BRIGHTNESS:"
}

mon_brightness_up () {
	brightnessctl -q -n 0 set +5% &&
		mon_brightness_display
}

mon_brightness_down () {
	brightnessctl -q -n 0 set 5%- &&
		mon_brightness_display
}

kbd_brightness_display () {
	local max=$(cat /sys/class/leds/dell:kbd_backlight/max_brightness)
	local cur=$(cat /sys/class/leds/dell:kbd_backlight/brightness)
	local val=$(echo "scale=2; ($cur / $max) * 100" | bc)

	dunstify -a brightness -h int:value:$val -i gpm-brightness-kbd "KEYBOARD BRIGHTNESS:"
}

kbd_brightness_adj () {
	brightnessctl -d 'dell::kbd_backlight' set $(( $(brightnessctl -d 'dell::kbd_backlight' get) + 1 % 2 )) &&
		kbd_brightness_adj
}

if [[ $1 == "up" ]]; then
	mon_brightness_up
elif [[ $1 == "down" ]]; then
	mon_brightness_down
elif [[ $1 == "kbd" ]]; then
	kbd_brightness_adj
else 
	echo "usage: bright.sh [up/down/kbd]"
fi
