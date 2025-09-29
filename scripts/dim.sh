#!/bin/sh

win_id=$(xdotool getactivewindow 2>/dev/null)
if [ -z "$win_id" ]; then
    echo "Kein aktives Fenster gefunden."
    exit 1
fi

# Fensterposition und -größe holen
eval $(xdotool getwindowgeometry --shell "$win_id" 2>/dev/null)
win_x=$X
win_y=$Y

if [ -z "$win_x" ] || [ -z "$win_y" ]; then
    echo "Konnte Fensterposition nicht ermitteln."
    exit 1
fi

# Alle Monitore auslesen und passende Geometrie finden
xrandr | grep ' connected' | while read -r line; do
    name=$(echo "$line" | cut -d' ' -f1)
    geom=$(echo "$line" | grep -o '[0-9]\+x[0-9]\++[0-9]\++[0-9]\+')

    if [ -z "$geom" ]; then
        continue
    fi

    res_x=$(echo "$geom" | cut -d'x' -f1)
    rest=$(echo "$geom" | cut -d'x' -f2)
    res_y=$(echo "$rest" | cut -d'+' -f1)
    offset_x=$(echo "$rest" | cut -d'+' -f2)
    offset_y=$(echo "$rest" | cut -d'+' -f3)

    # Prüfen, ob alle Variablen gesetzt sind
    if [ -z "$res_x" ] || [ -z "$res_y" ] || [ -z "$offset_x" ] || [ -z "$offset_y" ]; then
        continue
    fi

    # Fokusmonitor anhand Fensterposition bestimmen
    if [ "$win_x" -ge "$offset_x" ] && [ "$win_x" -lt $((offset_x + res_x)) ] &&
       [ "$win_y" -ge "$offset_y" ] && [ "$win_y" -lt $((offset_y + res_y)) ]; then
				maim -g "${res_x}x${res_y}+${offset_x}+${offset_y}" ~/media/pictures/screenshots/$(date +%Y-%m-%d_%H:%M:%S).png
				exec notify-send "Screenshot saved"
        exit 0
    fi
done

