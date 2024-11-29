#!/bin/bash

monitors=$(hyprctl monitors all | grep Monitor | awk '{print $2}')

# wf-recorder -f $(xdg-user-dir Videos)/$(date +'%H:%M:%S_%d-%m-%Y.mp4')
# killall -s SIGINT wf-recorder

chosen=$(echo -e "$monitors" | rofi -dmenu -i -p "Select a Monitor:")

case $chosen in
    "")
        echo "No monitor selected, exiting."
        exit 1
        ;;
    *): 
        echo "Selected monitor: $chosen"
        wf-recorder -f $(xdg-user-dir Videos)/$(date +'%H:%M:%S_%d-%m-%Y').mp4 -o $chosen
        ;;
    *)
        echo "Invalid option"
        ;;
esac
