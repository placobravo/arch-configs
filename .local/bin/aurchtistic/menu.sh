#!/usr/bin/env sh

lock_screen () {

    # Checks if lockscreen file (blurred background + lock pic) was already created
    if [ ! -e /tmp/aurchtistic/lockscreen.jpg ] || [ ! -d "/tmp/aurchtistic" ]; then
        mkdir /tmp/aurchtistic
        magick "$LOCKSCREEN" "$LOCK_ICON" -gravity center -composite -quality 100 /tmp/aurchtistic/lockscreen.jpg
    fi

    swaylock -i /tmp/aurchtistic/lockscreen.jpg

}

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
            lock_screen
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
