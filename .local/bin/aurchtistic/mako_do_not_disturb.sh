#!/usr/bin/bash

pid=$(pgrep mako)

if [[ $1 = "toggle" ]]; then

	if pgrep -x mako >/dev/null; then
		mako
	fi

	if ! makoctl mode | grep do-not-disturb; then
		makoctl mode -a do-not-disturb
	else
		makoctl mode -r do-not-disturb
	fi
fi

if ! makoctl mode | grep do-not-disturb &>/dev/null; then
	echo "🔔 "
	echo "Notifications are on"
else
	echo "🔕 "
	echo "Notifications are off"
fi
