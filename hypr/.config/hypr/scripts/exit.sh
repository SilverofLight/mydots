#!/bin/bash

# 定义菜单选项
options=" ⏻ Shutdown\n  Reboot\n 󰿅 Logout\n 󰒲 Suspend\n 󰌾 Lock"

# 使用 rofi 提示选择
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power options:")

# 根据选择执行相应的命令
case $chosen in
    " ⏻ Shutdown")
        systemctl poweroff -i
        ;;
    "  Reboot")
        systemctl reboot
        ;;
    " 󰿅 Logout")
        hyprctl dispatch exit
        ;;
    " 󰒲 Suspend")
        systemctl suspend
        ;;
    " 󰌾 Lock")
        swaylock
        ;;
    *)
        exit 0
        ;;
esac
