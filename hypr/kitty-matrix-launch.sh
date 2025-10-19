#!/bin/bash

# Always switch to workspace 10
hyprctl dispatch workspace 10
sleep 0.3

# Launch all kitty windows with commands
kitty --class showoff_term &
sleep 0.3
kitty --class showoff_btop -e btop &
sleep 0.3
kitty --class showoff_cmatrix -e cmatrix &
sleep 0.3
kitty --class showoff_clock -e tty-clock -c -C 6 &
sleep 0.3
kitty --class showoff_cava -e cava &
sleep 0.5

# Function to tile and place windows (optional cleanup/merge if needed)
tile_and_place() {
    class=$1
    direction=$2
    sleep 0.2
    winaddr=$(hyprctl clients -j | jq -r ".[] | select(.class==\"$class\" and .workspace.id==10) | .address")
    if [ -n "$winaddr" ]; then
        hyprctl dispatch focuswindow address:$winaddr
        hyprctl dispatch layoutmsg split$direction
    fi
}

# Start with the first window focused
hyprctl dispatch focuswindow class:showoff_term

# Now split and place other windows in desired layout
tile_and_place showoff_btop d       # Split down from terminal
tile_and_place showoff_cmatrix r    # Split right from terminal
tile_and_place showoff_clock d      # Split down from cmatrix
tile_and_place showoff_cava d       # Final cava split down

# Done

