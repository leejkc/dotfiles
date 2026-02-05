#!/bin/bash

STATUS=$(cat /sys/class/power_supply/AC/online)

if [ "$POWERSTATUS" = "1" ]
then
	hyprctl keyword monitor "eDP-1,1920x1080@120,0x0,1"
el
hy
