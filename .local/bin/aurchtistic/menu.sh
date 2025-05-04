#!/usr/bin/env sh

powermenu () {
    pmenu=$(echo -e "Logout\nPoweroff\nReboot\nSuspend\nLock" | tofi)

    case $pmenu in
        "Logout")
            sway exit
            ;;
        "Poweroff")
            systemctl poweroff
            ;;
        "Reboot")
            systemctl reboot
            ;;
        "Suspend")
            systemctl suspend
            ;;
        "Lock")
            swaylock -i $LOCKSCREEN
            ;;
    esac
}

manual () {
    page=$(man --apropos . | tofi | awk '{print $1}')
    [ -n "$page" ] && man --troff-device=pdf "$page" | zathura -
}

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
        manual
        ;;
    "Powermenu")
        powermenu
        ;;
esac
