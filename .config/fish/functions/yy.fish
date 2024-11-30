function yy
	set -l tmp $(mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	set -l cwd $(cat -- "$tmp")

	if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
