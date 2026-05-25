#!/bin/bash
# =============================================================================
#  Rofi power menu — apagar, reiniciar, suspender, cerrar sesión, bloquear
# =============================================================================

entries="󰌾 Lock\n󰤄 Suspend\n󰒲 Hibernate\n󰑐 Logout\n󰜉 Reboot\n󰐥 Shutdown"

selected=$(echo -e "$entries" | rofi -dmenu \
    -p "Power" \
    -theme-str 'listview { lines: 6; }' \
    -theme-str 'window { width: 200px; }' \
    -config ~/.config/rofi/config.rasi)

case "$selected" in
    *Lock)     hyprlock ;;
    *Suspend)  systemctl suspend ;;
    *Hibernate) systemctl hibernate ;;
    *Logout)   hyprctl dispatch exit ;;
    *Reboot)   systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
