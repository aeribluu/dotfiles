#!/bin/sh

# Power menu script using rofi

CHOSEN=$(printf " Lock\n󰒲 Suspend\n Reboot\n Shutdown\n󰍃 Log Out" | rofi -dmenu -i)

case "$CHOSEN" in
	" Lock") i3lock -i /home/kityn/Pictures/blob-scene-haikei.png ;;
	"󰒲 Suspend") systemctl suspend-then-hibernate ;;
	" Reboot") reboot ;;
	" Shutdown") poweroff ;;
	"󰍃 Log Out") i3-msg exit ;;
	*) exit 1 ;;
esac
