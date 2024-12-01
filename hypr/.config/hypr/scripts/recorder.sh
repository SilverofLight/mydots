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
audio_sources=$(pactl list sources | grep Name | cut -d: -f2)

chosen_monitor=$(echo -e "$monitors" | rofi -dmenu -i -p "选择显示器:")
[ -z "$chosen_monitor" ] && exit 1

# 选择音频源
chosen_audio=$(echo -e "$audio_sources\n no audio" | rofi -dmenu -i -p "选择音频源:")

record_cmd="wf-recorder"

if [ "$chosen_audio" != " no audio" ] && [ -n "$chosen_audio" ]; then
    record_cmd+=" -a --audio-source $chosen_audio"
fi

pkill -RTMIN+8 waybar
$record_cmd -f "$HOME/Videos/$(date +'%H:%M:%S_%d-%m-%Y').mp4" -o "$chosen_monitor" &
pkill -RTMIN+8 waybar

# notify-send "Recording Started" "Monitor: $chosen_monitor\nAudio: ${chosen_audio:-no audio}"
