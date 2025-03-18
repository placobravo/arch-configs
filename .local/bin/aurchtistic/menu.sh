#!/usr/bin/env sh

selection=$(echo "Applications
Select clipboard entry
Delete a clipboard entry
Manual pages
Powermenu
" | tofi)

case $selection in
    "Applications")
        tofi-drun --drun-launch=true
        ;;
    "Select clipboard entry")
        cliphist list | tofi | cliphist decode | wl-copy
        ;;
    "Delete a clipboard entry")
        cliphist list | tofi | cliphist delete
        ;;
    "Manual pages")
        page=$(man --apropos . | tofi | awk '{print $1}')
        [ -n "$page" ] && man --troff-device=pdf "$page" | zathura -
        ;;
    "Powermenu")
        echo -e "poweroff\nreboot\nsuspend" | tofi | xargs systemctl
        ;;
esac
