diff <(
	cat \
		<(pacman -Qe | awk '{print $1}') \
		<(pacman -Qm | awk '{print $1}') \
		<(flatpak list --app | sed -e 's/^[^\t]*\t//' -e 's/\t.*//')
) \
	<(sed -e 's/[^,]*,//' -e 's/,.*//' /home/davide/Stuff/aurchtistic/packages.csv | tail -n +2) | grep "^[<>-]"

echo
echo

cp -f /home/davide/Stuff/aurchtistic/packages.csv /tmp/packages.csv

cat /tmp/packages.csv
echo
echo

patch /tmp/packages.csv <(diff <(
	cat \
		<(pacman -Qe | awk '{print $1}') \
		<(pacman -Qm | awk '{print $1}') \
		<(flatpak list --app | sed -e 's/^[^\t]*\t//' -e 's/\t.*//')
) \
	<(sed -e 's/[^,]*,//' -e 's/,.*//' /home/davide/Stuff/aurchtistic/packages.csv | tail -n +2))

echo
echo
cat /tmp/packages.csv
