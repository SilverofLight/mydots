#!/bin/bash

proxise=(
  "♻️ 自动选择"
  "🎯 全球直连"
  "Hong Kong_1"
  "Hong Kong_2"
  "Hong Kong_3"
  "Hong Kong_4"
  "Hong Kong_5"
  "Hong Kong_6"
  "Hong Kong_7"
  "Hong Kong_8"
  "Hong Kong_9"
  "Hong Kong_10"
  "Hong Kong_11"
  "Hong Kong_12"
  "Japan_1"
  "Japan_2"
  "Japan_3"
  "Japan_4"
  "Japan_5"
  "Japan_6"
  "Japan_7"
  "Japan_8"
  "Japan_9"
  "Japan_10"
  "Japan_11"
  "Japan_12"
  "Japan_13"
  "Japan_14"
  "Japan_15"
  "Singapore_01"
  "Singapore_02"
  "Singapore_03"
  "Singapore_04"
  "Singapore_05"
  "Singapore_06"
  "Singapore_07"
  "Singapore_08"
  "Singapore_09"
  "Singapore_10"
  "United States_1"
  "United States_2"
  "United States_3"
  "United States_4"
  "Taiwan_1"
  "Taiwan_2"
  "韩国"
  "Vietnam"
  "澳大利亚"
  "马来西亚"
  "印度"
)

proxies_list=$(printf '%s\n' "${proxise[@]}")

passwd=$(cat ~/Documents/mihomo_select)

if [ -z "$passwd" ]; then
  exit 1
fi

proxy_name=$(echo -e "$proxies_list" | wofi --dmenu --prompt "Select Proxy" -c ~/.config/wofi/config_proxy)

if [ -z "$proxy_name" ]; then
  echo -e "\033[31merror: proxy_name is required\033[0m"
  exit 1
fi

msg=$(curl -X PUT "http://127.0.0.1:9090/proxies/%F0%9F%94%B0%20%E8%8A%82%E7%82%B9%E9%80%89%E6%8B%A9" \
        -H "Authorization: Bearer $passwd" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$proxy_name\"}")

if [ -n "$msg" ]; then
  notify-send "$msg"
fi
