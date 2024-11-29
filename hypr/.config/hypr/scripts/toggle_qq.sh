#!/bin/bash

if [ -f $HOME/Templates/toggle_qq ]; then
    echo "文件存在"
    index=$(cat $HOME/Templates/toggle_qq)
    if [ $index -eq 1 ]; then
        hyprctl dispatch workspace 9
        echo "0" > "$HOME/Templates/toggle_qq"
    else
        hyprctl dispatch focuscurrentorlast
        echo "1" > "$HOME/Templates/toggle_qq"
    fi
else
    echo "文件不存在"
    echo "1" > "$HOME/Templates/toggle_qq"
fi

