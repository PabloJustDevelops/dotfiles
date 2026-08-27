#!/bin/sh
set -eu

choice=$(printf '%s\n' 'Lock' 'Logout' 'Suspend' 'Reboot' 'Shutdown' | rofi -dmenu -i -p 'Power')
case "$choice" in
    Lock) loginctl lock-session ;;
    Logout) riverctl exit ;;
    Suspend) systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
