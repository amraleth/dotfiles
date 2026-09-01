#!/bin/sh
while true; do
    cap=$(cat /sys/class/power_supply/BAT0/capacity)
    stat=$(cat /sys/class/power_supply/BAT0/status)
    disk=$(df -h / | awk 'NR==2 {print $4}')
    ip=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')
    mem=$(free -h | awk 'NR==2 {print $7}')
    load=$(cut -d' ' -f1-3 /proc/loadavg)

    case "$stat" in
        Charging) bicon="󰂄" ;;
        Full)     bicon="󰁹" ;;
        *)
            if   [ "$cap" -ge 90 ]; then bicon="󰁹"
            elif [ "$cap" -ge 70 ]; then bicon="󰂀"
            elif [ "$cap" -ge 50 ]; then bicon="󰁾"
            elif [ "$cap" -ge 30 ]; then bicon="󰁻"
            elif [ "$cap" -ge 15 ]; then bicon="󰁺"
            else bicon="󰂎"
            fi
            ;;
    esac

    printf '󰀂 %s  󰍛 %s  󰋊 %s  󰘚 %s  %s %s%%  󰃰 %s\n' \
        "${ip:-offline}" "$load" "$disk" "$mem" "$bicon" "$cap" \
        "$(date '+%Y-%m-%d %H:%M')"
    sleep 5
done
