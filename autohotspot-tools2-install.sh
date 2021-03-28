#!/bin/bash
MYPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOGO=$MYPATH/logo.png
$MYPATH/base-install.sh
#####################################
#	notice to user
#####################################
cat <<EOF > $MYPATH/intro.txt
autohotspot-tools2-install by wb0sio.
This script installs the Hotspot Tools2 .desktop file
and updates the pi-build installation to use this version.
EOF

INTRO=$(yad --width=550 --height=250 --text-align=center --center --title="Install Autohotspot-Tools2"  --show-uri \
--image $LOGO --window-icon=$LOGO --image-on-top --separator="|" --item-separator="|" \
--text-info<$MYPATH/intro.txt \
--button="Continue":2 > /dev/null 2>&1)
BUT=$?
if [ $BUT = 252 ]; then
rm $MYPATH/intro.txt
exit
fi
rm $MYPATH/intro.txt

# Install Autohotspot-Tools2 
cp -f $HOME/hotspot-tools2/hstools.desktop $HOME/.local/share/applications/hotspot-tools.desktop
sed -i "s/km4ack\/hotspot-tools2/lcgreenwald\/autohotspot-tools2/" $HOME/pi-build/update
sed -i "s/km4ack\/hotspot-tools2/lcgreenwald\/autohotspot-tools2/" $HOME/pi-build/functions/base.function


# done
yad --width=400 --height=200 --title="Complete" --image $LOGO \
--text-align=center --skip-taskbar --image-on-top \
--wrap --window-icon=$LOGO \
--undecorated --text="<big><big><big><b>autohotspot-tools2 install finished \r Run it from the Hamradio section of the Main Menu. </b></big></big></big>\r\r" \
--button="Exit":0
BUT=$(echo $?)

if [ $BUT = 0 ]; then
exit
elif [ $BUT = 1 ]; then
exit
fi
