#!/bin/bash

feh --bg-fill ~/Pictures/wallpaper/old.png
picom --config ~/.config/picom/picom.conf &

fcitx5 &
numlockx on &

# while true; do
#   ~/.dwm/reflashBar.sh
#     sleep 3 
# done &


# while true; do
#   ~/.dwm/random_wallpaper.sh
#   sleep 180
# done &

killall bar.sh
sleep 1
~/.dwm/bar.sh &

killall xdotool.sh
sleep 1
~/.dwm/xdotool.sh &

dunst &

