#!/bin/bash

# 检查是否已经在录制
if pgrep -x "wf-recorder" > /dev/null; then
    # 如果正在录制，则停止录制
    killall -s SIGINT wf-recorder
    pkill -RTMIN+8 waybar
    notify-send "录制结束" "视频已保存"
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
        wf-recorder -a -f $HOME/Videos/$(date +'%H:%M:%S_%d-%m-%Y').mp4 -o $chosen
		pkill -RTMIN+8 waybar
        ;;
esac
