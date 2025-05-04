# Functions are only used to keep the code clean
# They all unset themselves after being run

function pick_lockscreen
    set -l cache_dir $HOME/.cache/aurchtistic/lockscreens
    set -l LOCKSCREEN $cache_dir/(string replace -r '\.(\w+)' '_lock.$1' (basename $BACKGROUND))
    set -l LOCK_ICON $BACKGROUNDS_DIR/lock.png

    # Test if lockscreen exists
    # i.e. if "Lockscreens/image_lock.png" exists when "image.png" is current $BACKGROUND
    if test ! -e $LOCKSCREEN
        mkdir -p $cache_dir 2>/dev/null
        magick $BACKGROUND -blur 0x8 -quality 100 - | magick - $LOCK_ICON -gravity center -composite -quality 100 $LOCKSCREEN
    end

    echo $LOCKSCREEN
    functions -e pick_lockscreen
end

function pick_background
    set -l pics $BACKGROUNDS_DIR/*.jpg $BACKGROUNDS_DIR/*.jpeg

    if count $pics >/dev/null
        echo $pics[(random 1 (count $pics))]
    end
    functions -e pick_background
end

if status is-login
    # $PATH
    set -a PATH /home/$USER/.local/bin
    set -a PATH /home/$USER/.local/bin/aurchtistic
    set -a PATH /var/lib/flatpak/exports/bin
    
    # System variables
    set -gx EDITOR "nvim"
    set -gx TERMINAL "foot"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_CACHE_HOME "$HOME/.cache"
    set -gx QT_QPA_PLATFORM "wayland;xcb"
    set -gx QT_AUTO_SCREEN_SCALE_FACTOR 0
    set -gx QT_SCALE_FACTOR 1
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx GDK_SCALE 1
    set -gx GDK_DPI_SCALE 1
    set -gx GTK_THEME Adwaita:dark
    set -gx XDG_CURRENT_DESKTOP sway
    set -gx MANPAGER "nvim +Man!"
    set -gx BACKGROUNDS_DIR "$HOME/Stuff/Wallpapers"
    set -gx BACKGROUND (pick_background) 
    set -gx LOCKSCREEN (pick_lockscreen)
    
    # Fish Config
    set -g fish_key_bindings fish_vi_key_bindings
    
    # Login manager
    if test "$(tty)" = "/dev/tty1"
        if test -z $wm 
            set -gx wm "$(whiptail --nocancel --notags \
                --title "Select Compositor" --radiolist " " 0 0 0 \
                sway "Sway Window Manager" on \
                cosmic "Cosmic Desktop" off \
                3>&1 1>&2 2>&3 3>&1)"
            if test $wm = "sway"
                exec sway
            else if test $wm = "cosmic"
                exec start-cosmic
            else
                :
            end
        end
    end
end
