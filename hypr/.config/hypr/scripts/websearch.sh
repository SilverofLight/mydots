#!/bin/bash

# author: Silver Lee
# date: 2025/5/15
# description: use wofi to search in wek
# requirements: wofi, zen-browser

touch $HOME/Templates/searchHistory
text=$(cat $HOME/Templates/searchHistory | wofi --dmenu --prompt "search")

command="env GTK_IM_MODULE=fcitx,QT_IM_MODULE=fcitx,XMODIFIERS=@im=fcitx /opt/zen-browser-bin/zen-bin"

if [ -z $text ]; then
  exit 1
fi

echo $text >> $HOME/Templates/searchHistory

if [[ $text =~ ^d\ * ]]; then
  prompt=$(echo "$text" | cut -d' ' -f2 | sed -E 's/ +/+/g')
  $command https://duckduckgo.com/?q=$prompt&ia=web
elif [[ $text =~ ^b\ * ]]; then
  prompt=$(echo "$text" | cut -d' ' -f2 | sed -E 's/ +/+/g')
  $command https://search.bilibili.com/all?keyword=$prompt
else
  prompt=$(echo "$text" | sed -E 's/ +/+/g')
  $command https://duckduckgo.com/?q=$prompt&ia=web
fi

