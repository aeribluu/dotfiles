#!/bin/bash

# Enable debugging output (useful for seeing what the script is doing)
set -x

# Define the WM_CLASS for pavucontrol
PAVUCONTROL_CLASS="pavucontrol"
PAVUCONTROL_PATH="/usr/bin/pavucontrol" # Make sure this is your actual path from 'which pavucontrol'

echo "--- Script Start ---"
echo "Checking for existing pavucontrol window (class: $PAVUCONTROL_CLASS)..."

# Check if pavucontrol is currently running anywhere in the i3 tree
# This checks for the window's existence regardless of current workspace or visibility.
if i3-msg -t get_tree | jq -e ".nodes[] | recurse(.nodes[]) | select(.window_properties.class == \"$PAVUCONTROL_CLASS\")" > /dev/null; then
    echo "Pavucontrol window found. Attempting to focus and kill it."
    # If it exists, focus it (brings it to current workspace if needed)
    i3-msg '[class="'"$PAVUCONTROL_CLASS"'"] focus'
    # Add a small delay to ensure focus has taken effect before killing
    sleep 0.1
    # Then kill it
    i3-msg '[class="'"$PAVUCONTROL_CLASS"'"] kill'
    echo "Focus and kill commands sent for existing window."
else
    echo "Pavucontrol window not found. Launching a new instance."
    # If it's not running, launch it
    "$PAVUCONTROL_PATH" &
    echo "Launch command sent for new instance."
fi

echo "--- Script End ---"

# Disable debugging output
set +x
