#!/usr/bin/bash
# roconf="~/.config/rofi/clipboard.rasi"
# roconf="~/.config/rofi/config.rasi"

case $1 in
    c)  cliphist list | wofi --dmenu --prompt 'Clipboard' | cliphist decode | wl-copy
        ;; 
    d)  cliphist list | wofi --dmenu  | cliphist delete
        ;;
    w)  if [ echo -e "Yes\nNo" | wofi --dmenu ] ; then
            cliphist wipe
        fi
        ;;
    t)  echo ""
        echo "󰅇 clipboard history"
        ;;
    *)  echo "cliphist.sh [action]"
        echo "c :  cliphist list and copy selected"
        echo "d :  cliphist list and delete selected"
        echo "w :  cliphist wipe database"
        echo "t :  display tooltip"
        ;;
esac

