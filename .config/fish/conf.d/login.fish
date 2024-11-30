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

	# Fish Config
	set -g fish_key_bindings fish_vi_key_bindings

	exec sway
end
