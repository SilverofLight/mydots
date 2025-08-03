#!/bin/env python

import json
import os
import sys
import curses
import subprocess

# 文件路径，假设数据存储在 input.json 文件中
home = os.getenv("HOME")
file_path = os.path.join(home, ".local", "state", "mpv", "watch_history.jsonl")

# 读取文件中的 JSON 行数据
data = []
if os.path.exists(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            try:
                item = json.loads(line.strip())
                data.append(item)
            except json.JSONDecodeError:
                print(f"Skipping invalid JSON line: {line.strip()}")
else:
    print(f"File not found: {file_path}")
    exit(1)

# 去重并倒序处理数据，同时保留路径信息
seen = set()
unique_items = []
for item in reversed(data):
    output = item.get("title", os.path.basename(item["path"]))
    if output not in seen:
        seen.add(output)
        # 保存显示名称和实际路径
        unique_items.append({
            "display": output,
            "path": item["path"]
        })

# 终端界面函数
def main(stdscr):
    # 设置 curses
    curses.curs_set(0)  # 隐藏光标
    stdscr.timeout(100)  # 刷新频率
    current_row = 0  # 当前选中行

    while True:
        stdscr.clear()
        # 显示标题
        stdscr.addstr(0, 0, "Select an item (UP/e=上移, DOWN/n=下移, ENTER=播放, Q=退出):", curses.A_BOLD)

        # 显示列表并高亮选中项
        for idx, item in enumerate(unique_items):
            if idx == current_row:
                stdscr.addstr(idx + 2, 0, f"> {item['display']}", curses.A_REVERSE)
            else:
                stdscr.addstr(idx + 2, 0, f"  {item['display']}")

        stdscr.refresh()

        # 获取用户输入
        try:
            key = stdscr.getch()
        except:
            continue

        # 处理按键
        if key == curses.KEY_UP and current_row > 0:
            current_row -= 1
        elif key == ord('e') and current_row > 0:  # e 键上移
            current_row -= 1
        elif key == curses.KEY_DOWN and current_row < len(unique_items) - 1:
            current_row += 1
        elif key == ord('n') and current_row < len(unique_items) - 1:  # n 键下移
            current_row += 1
        elif key in [10, curses.KEY_ENTER]:  # 回车键播放
            selected_item = unique_items[current_row]
            return selected_item["path"]  # 返回选中的文件路径
        elif key == ord('q') or key == ord('Q'):
            return None

# 运行 curses 程序
if __name__ == "__main__":

    if len(sys.argv) < 2:
        selected_path = unique_items[0]["path"]
    elif sys.argv[1] == "-l":
        selected_path = curses.wrapper(main)
    else:
        print("使用方法：")
        print("mpvh.py -l == 查看历史记录列表")
        print("mpvh.py    == 打开最后播放的视频")
    
    if selected_path:
        print(f"正在使用 mpv 播放: {selected_path}")
        # 使用 mpv 播放选中的文件
        try:
            subprocess.run(["mpv", selected_path])
        except FileNotFoundError:
            print("错误: 未找到 mpv 播放器，请确保已安装 mpv")
        except Exception as e:
            print(f"播放时出错: {str(e)}")
