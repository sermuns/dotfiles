#!/bin/bash
MODE_FILE="$HOME/.cache/darkmode"

niri msg action do-screen-transition --delay-ms 10

if [ -f "$MODE_FILE" ] && grep -q "dark" "$MODE_FILE"; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    sed -i 's/^ColorScheme=.*$/ColorScheme=Breeze/' ~/.config/kdeglobals 2>/dev/null
    echo "light" > "$MODE_FILE"
else
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita:dark'
    sed -i 's/^ColorScheme=.*$/ColorScheme=BreezeDark/' ~/.config/kdeglobals 2>/dev/null
    echo "dark" > "$MODE_FILE"
fi
