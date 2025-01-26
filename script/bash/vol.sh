!/bin/bash

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

if [[ -z "$1" ]]; then
	get_vol
elif [[ "$1" == "--down" ]]; then
	dec
elif [[ "$1" == "--up" ]]; then
	inc
fi
