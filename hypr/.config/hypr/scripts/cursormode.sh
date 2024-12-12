#!/bin/bash

# author: Silver Lee
# date: 2024/12/12
# description: use hyprctl to move cursor
# requirements: hyprland

position=$(hyprctl cursorpos)

xpos=$(echo -e "$position" | grep -o '^[0-9]*')
ypos=$(echo -e "$position" | grep -o '[0-9]*$')

case $1 in
    h) hyprctl dispatch movecursor `expr $xpos - 100` $ypos;;
    l) hyprctl dispatch movecursor `expr $xpos + 100` $ypos;;
    j) hyprctl dispatch movecursor $xpos `expr $ypos + 100`;;
    k) hyprctl dispatch movecursor $xpos `expr $ypos - 100`;;
esac
