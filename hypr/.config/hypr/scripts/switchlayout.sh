#!/bin/bash

IsDvorak=$(hyprctl devices | grep Dvorak | wc -l)

if [ $IsDvorak == 0 ]; then
    notify-send "Switching to Dvorak"
    hyprctl keyword input:kb_variant "dvorak"
else
    notify-send "Switching to Qwerty"
    hyprctl keyword input:kb_variant ""
fi