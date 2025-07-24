#!/usr/bin/env bash

# Icons for signal + security
RAMP_OPEN=(󰤫 󰤟 󰤢 󰤥 󰤨)
RAMP_LOCKED=(󰤬 󰤡 󰤤 󰤧 󰤪)
RAMP_UNLOCKED=(󱛏 󱛋 󱛌 󱛍 󱛎)

# Notify user
notify-send "Wi-Fi" "Getting list of available networks..."

# Saved connections (to determine 'unlocked')
saved_connections=$(nmcli -g NAME connection)

# Wi-Fi status toggle
wifi_status=$(nmcli radio wifi)
toggle="󰖪  Disable Wi-Fi"
[[ "$wifi_status" == "disabled" ]] && toggle="󰖩  Enable Wi-Fi"

# Build Wi-Fi list with icons
wifi_list=$(nmcli -f SSID,SECURITY,SIGNAL device wifi list | sed 1d | while read -r line; do
    # Normalize spacing
    line=$(echo "$line" | sed 's/  */ /g')

    # Extract fields
    ssid=$(echo "$line" | awk '{for (i=1; i<=NF-2; i++) printf $i " "; print ""}' | sed 's/ *$//')
    security=$(echo "$line" | awk '{print $(NF-1)}')
    signal=$(echo "$line" | awk '{print $NF}')

    [ -z "$ssid" ] && continue

    # Signal level index
    if (( signal >= 90 )); then
        i=4
    elif (( signal >= 75 )); then
        i=3
    elif (( signal >= 50 )); then
        i=2
    elif (( signal >= 25 )); then
        i=1
    else
        i=0
    fi

    # Icon based on security + saved
    if [[ "$security" =~ WPA ]]; then
        if echo "$saved_connections" | grep -Fxq "$ssid"; then
            icon="${RAMP_UNLOCKED[$i]}"
        else
            icon="${RAMP_LOCKED[$i]}"
        fi
    else
        icon="${RAMP_OPEN[$i]}"
    fi

    echo "$icon $ssid"
done)

# Show rofi menu
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq | rofi -dmenu -i -p "Wi-Fi SSID:")

# Cancel check
[ -z "$chosen_network" ] && exit

# Handle toggle options
if [[ "$chosen_network" == "󰖩  Enable Wi-Fi" ]]; then
    nmcli radio wifi on && notify-send "Wi-Fi" "Wi-Fi enabled"
    exit
elif [[ "$chosen_network" == "󰖪  Disable Wi-Fi" ]]; then
    nmcli radio wifi off && notify-send "Wi-Fi" "Wi-Fi disabled"
    exit
fi

# Extract icon and SSID
icon_prefix="${chosen_network%% *}"
chosen_id="${chosen_network#* }"

# Success message
success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."

# Connection flow
if echo "$saved_connections" | grep -Fxq "$chosen_id"; then
    nmcli connection up id "$chosen_id" | grep "successfully" \
        && notify-send "Connection Established" "$success_message"
else
    # Check if it's a locked icon
    if printf '%s\n' "${RAMP_LOCKED[@]}" | grep -qFx "$icon_prefix"; then
        wifi_password=$(rofi -dmenu -password -p "Password for $chosen_id:")
        [ -z "$wifi_password" ] && notify-send "Wi-Fi" "Cancelled. No connection attempt made." && exit
        nmcli device wifi connect "$chosen_id" password "$wifi_password" \
            | grep "successfully" && notify-send "Connection Established" "$success_message"
    else
        nmcli device wifi connect "$chosen_id" \
            | grep "successfully" && notify-send "Connection Established" "$success_message"
    fi
fi
