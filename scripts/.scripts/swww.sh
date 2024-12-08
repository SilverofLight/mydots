#!/bin/bash

# 壁纸存放目录
WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# 确保 swww daemon 正在运行
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init
fi

# 切换壁纸的函数
change_wallpaper() {
    # 随机选择一张图片
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)
    
    # 定义可用的过渡效果数组
    TRANSITIONS=("simple" "wipe" "grow" "center" "outer" "wave" "random" "any")
    # 随机选择一个过渡效果
    RANDOM_TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
    
    # 随机生成过渡位置
    POSITIONS=("top" "center" "bottom" "left" "right")
    RANDOM_POSITION=${POSITIONS[$RANDOM % ${#POSITIONS[@]}]}
    
    # 随机生成过渡持续时间（1-3秒）
    RANDOM_DURATION=$((RANDOM % 3 + 1))
    
    # 使用随机效果设置壁纸
    swww img "$WALLPAPER" \
        --transition-fps 60 \
        --transition-type "$RANDOM_TRANSITION" \
        --transition-pos "$RANDOM_POSITION" \
        --transition-duration "$RANDOM_DURATION"
}

# 根据脚本运行方式执行不同操作
if [[ $1 == "daemon" ]]; then
    # 作为后台程序运行，每隔一段时间更换壁纸
    while true; do
        change_wallpaper
        sleep 1200
    done
else
    # 直接运行则只更换一次壁纸
    change_wallpaper
fi
