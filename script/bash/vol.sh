#!/bin/bash

get_vol() {
	status="$(pactl -f json list sinks)"
	vol="$(echo "$status" | grep -oP '"value_percent":"\d+%"' | head -n 1 | grep -oP "\d+")"

	echo "$(((vol * 100) / 160))"
}

inc() {
	if [[ $(get_vol) -lt 100 ]]; then
		pactl set-sink-volume @DEFAULT_SINK@ +8%
	fi
}

dec() {
	pactl set-sink-volume @DEFAULT_SINK@ -8%
}

mute() {
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	if [[ $(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=mute: )|yes|no') == "yes" ]]; then
		eww update vol_dot_reveal=false
	else
		eww update vol_dot_reveal=true
	fi
}

if [[ -z "$1" ]]; then
	get_vol
elif [[ "$1" == "--down" ]]; then
	dec
elif [[ "$1" == "--up" ]]; then
	inc
elif [[ "$1" == "--mute" ]]; then
	mute
fi
