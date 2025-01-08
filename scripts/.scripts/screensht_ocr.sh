#!/bin/bash

# 创建临时文件来保存截图
temp_file=$(mktemp /tmp/screenshot-XXXXXX.png)

# 使用 grimblast 截取选定区域
grimblast save area "$temp_file"

# 检查截图是否成功
if [ $? -ne 0 ]; then
    echo "截图失败"
    rm "$temp_file"
    exit 1
fi

# 运行 OCR 脚本处理图片
python3 $HOME/mydots/scripts/.scripts/ocr.py "$temp_file"

# 删除临时文件
rm "$temp_file"
