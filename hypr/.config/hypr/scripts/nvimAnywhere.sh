#!/bin/bash

# author: Silver Lee
# date: 2025/1/30
# description: use nvim to edit a temporary file and copy the content to clipboard
# requirements: kitty, nvim, wl-copy || xclip || pbcopy

temp_file=$(mktemp /tmp/nvimAnywhere.XXXXXX.md)

# st -T nvimAnywhere fish -c "nvim $temp_file"
kitty -T nvimAnywhere fish -c "nvim $temp_file"

if command -v wl-copy &> /dev/null; then
    cat "$temp_file" | wl-copy
elif command -v xclip &> /dev/null; then
    cat "$temp_file" | xclip -selection clipboard
elif command -v pbcopy &> /dev/null; then
    cat "$temp_file" | pbcopy
else
    echo "未找到 wl-copy, xclip 或 pbcopy，无法复制到剪切板"
fi

rm "$temp_file"
