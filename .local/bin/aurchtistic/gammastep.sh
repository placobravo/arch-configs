#!/usr/bin/bash

pid=$(pgrep gammastep)

if [[ $1 = "toggle" ]]; then
	if pgrep -x "gammastep" >/dev/null; then
		kill -9 $(pgrep -x "gammastep")
	else
		gammastep -O 3000 &
	fi
fi

if pgrep -x "gammastep" >/dev/null; then
	echo "🌕 "
	echo "Nightlight is on"
else
	echo "☀️ "
	echo "Nightlight is off"
fi
