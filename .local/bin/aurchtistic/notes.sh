#!/usr/bin/bash

if pgrep -x "nextcloud" >/dev/null; then
	foot -F nvim /home/davide/Nextcloud/Notes/Al_Volo/230_Soia_Riso.md
else
	notify-send "You need to sync your notes first!"
fi
