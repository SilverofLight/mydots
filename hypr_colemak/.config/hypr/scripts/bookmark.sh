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
    "giantesswaltz | https://giantesswaltz.org/index.php"
    "Hyprland WIki | https://wiki.hyprland.org/"
    "Xiao Ya(xn ya) | https://whut.ai-augmented.com/app/jx-web/mycourse"
    "Desmos | https://www.desmos.com/calculator?lang=zh-CN"
    "Whut | https://jwxt.whut.edu.cn/jwapp/sys/homeapp/home/index.html?av=1733997482198&contextPath=/jwapp#/"
    "Miao Miao | https://xn--6krx87aehra.com/"
    "New York Time | https://www.nytimes.com/"
    "Yin He(ybhe) | https://nf.video/?sharedId=77066"
    "Aur | https://aur.archlinux.org/"
    "DeepSeek | https://chat.deepseek.com/"
    "DeepSeekAPI | https://platform.deepseek.com/usage"
    "wikipedia | https://en.wikipedia.org/wiki/Main_Page"
    "whutvnp | https://webvpn.whut.edu.cn/login"
    "colemak | https://colemak.com/Learn"
)

bookmark_list=$(printf '%s\n' "${bookmarks[@]}")

selected_bookmark=$(echo -e "$bookmark_list" | rofi -dmenu -i -p "Bookmarks")

if [ -z "$selected_bookmark" ]; then
    exit 1
fi

url=$(echo "$selected_bookmark" | cut -d'|' -f2 | tr -d ' ')

env GTK_IM_MODULE=fcitx,QT_IM_MODULE=fcitx,XMODIFIERS=@im=fcitx /opt/zen-browser-bin/zen-bin "$url"
