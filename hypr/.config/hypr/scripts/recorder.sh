#!/bin/bash

# check if is recording
if pgrep -x "wf-recorder" > /dev/null; then
    pkill -RTMIN+8 waybar
    killall -s SIGINT wf-recorder
    pkill -RTMIN+8 waybar
    notify-send "Recording Finished" "The video is saved"
    exit 0
fi

monitors=$(hyprctl monitors all | grep Monitor | awk '{print $2}')

chosen=$(echo -e "$monitors" | rofi -dmenu -i -p "Select a Monitor:")

case $chosen in
    "")
        echo "No monitor selected, exiting."
        exit 1
        ;;
    *): 
        echo "Selected monitor: $chosen"
		pkill -RTMIN+8 waybar
        wf-recorder -a -f $HOME/Videos/$(date +'%H:%M:%S_%d-%m-%Y').mp4 -o $chosen
		pkill -RTMIN+8 waybar
        ;;
esac
