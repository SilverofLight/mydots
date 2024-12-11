#!/bin/bash

# author: Silver Lee
# date: 2024/12/11
# description: use rofi to select a bookmark
# requirements: rofi, brave-bin

bookmarks=(
    "Arch Wiki | https://wiki.archlinuxcn.org/wiki/%E9%A6%96%E9%A1%B5"
    "Bilibili | https://www.bilibili.com/"
    "Youtube | https://www.youtube.com"
    "Twitter | https://x.com/home"
    "Github | https://github.com"
    "ChatGPT | https://chatgpt.com/"
    "3xUI | https://107.172.157.186:11451/Y1qibsv0kd0yjvp/panel/inbounds"
    "Clash | http://127.0.0.1:9090/ui/"
    "GiantessNight | https://giantessnight.com/"
    "Hyprland WIki | https://wiki.hyprland.org/"
)

bookmark_list=$(printf '%s\n' "${bookmarks[@]}")

selected_bookmark=$(echo -e "$bookmark_list" | rofi -dmenu -i -p "Bookmarks")

if [ -z "$selected_bookmark" ]; then
    exit 1
fi

url=$(echo "$selected_bookmark" | cut -d'|' -f2 | tr -d ' ')

brave "$url"
