#!/bin/env python
from sqlcipher3 import dbapi2 as sqlite
import os
import subprocess
import sys
from tabulate import tabulate


def add_bookmark(url):
    home = os.getenv('HOME')
    database = os.path.join(home, '.config/hypr/scripts/bookmarks.db')

    try:
        with sqlite.connect(database) as conn:
            cursor = conn.cursor()

            # 设置加密密钥
            path = os.path.join(home, 'Documents/keys/bookmarks_key')
            with open(path, 'r', encoding='utf-8') as file:
                key = file.read().strip()
            if not key:
                subprocess.run(['notify-send', '错误', '环境变量 BOOKMARKS_KEY 未设置'])
                raise ValueError("环境变量 BOOKMARKS_KEY 未设置")
            cursor.execute(f"PRAGMA key = '{key}'")

            # 确保表存在
            cursor.execute(
                "CREATE TABLE IF NOT EXISTS bookmarks (name TEXT, url TEXT)")

            # 获取用户输入的名称
            name = input("请输入书签名称: ").strip()
            if not name:
                raise ValueError("书签名称不能为空")

            # 插入书签
            cursor.execute(
                "INSERT INTO bookmarks (name, url) VALUES (?, ?)", (name, url))
            conn.commit()
            subprocess.run(['notify-send', '成功', f'书签 "{name}" 已添加'])
            print(f"书签已添加: {name} | {url}")

    except sqlite.DatabaseError as e:
        # 捕获数据库相关错误（如密码错误）
        error_msg = f"数据库错误: {str(e)}"
        subprocess.run(['notify-send', '错误', '数据库密码错误或文件损坏'])
        print(error_msg)
        exit(1)
    except Exception as e:
        # 捕获其他异常
        error_msg = f"错误: {str(e)}"
        subprocess.run(['notify-send', '错误', error_msg])
        print(error_msg)
        exit(1)


def list_bookmarks():
    home = os.getenv('HOME')
    database = os.path.join(home, '.config/hypr/scripts/bookmarks.db')

    try:
        with sqlite.connect(database) as conn:
            cursor = conn.cursor()

            # 设置加密密钥
            path = os.path.join(home, 'Documents/keys/bookmarks_key')
            with open(path, 'r', encoding='utf-8') as file:
                key = file.read().strip()
            if not key:
                subprocess.run(['notify-send', '错误', '环境变量 BOOKMARKS_KEY 未设置'])
                raise ValueError("环境变量 BOOKMARKS_KEY 未设置")
            cursor.execute(f"PRAGMA key = '{key}'")

            # 查询所有书签
            cursor.execute("SELECT name, url FROM bookmarks")
            bookmarks = cursor.fetchall()

            if not bookmarks:
                print("没有找到书签")
                return

            # 使用 tabulate 格式化输出
            headers = ["书签名称", "URL"]
            print(tabulate(bookmarks, headers=headers, tablefmt="grid"))

    except sqlite.DatabaseError as e:
        error_msg = f"数据库错误: {str(e)}"
        subprocess.run(['notify-send', '错误', '数据库密码错误或文件损坏'])
        print(error_msg)
        exit(1)
    except Exception as e:
        error_msg = f"错误: {str(e)}"
        subprocess.run(['notify-send', '错误', error_msg])
        print(error_msg)
        exit(1)


def delete_bookmark(name):
    home = os.getenv('HOME')
    database = os.path.join(home, '.config/hypr/scripts/bookmarks.db')

    try:
        with sqlite.connect(database) as conn:
            cursor = conn.cursor()

            # 设置加密密钥
            path = os.path.join(home, 'Documents/keys/bookmarks_key')
            with open(path, 'r', encoding='utf-8') as file:
                key = file.read().strip()
            if not key:
                subprocess.run(['notify-send', '错误', '环境变量 BOOKMARKS_KEY 未设置'])
                raise ValueError("环境变量 BOOKMARKS_KEY 未设置")
            cursor.execute(f"PRAGMA key = '{key}'")

            # 检查书签是否存在
            cursor.execute("SELECT name FROM bookmarks WHERE name = ?", (name,))
            if not cursor.fetchone():
                raise ValueError(f"书签 '{name}' 不存在")

            # 删除书签
            cursor.execute("DELETE FROM bookmarks WHERE name = ?", (name,))
            conn.commit()
            subprocess.run(['notify-send', '成功', f'书签 "{name}" 已删除'])
            print(f"书签已删除: {name}")

    except sqlite.DatabaseError as e:
        error_msg = f"数据库错误: {str(e)}"
        subprocess.run(['notify-send', '错误', '数据库密码错误或文件损坏'])
        print(error_msg)
        exit(1)
    except Exception as e:
        error_msg = f"错误: {str(e)}"
        subprocess.run(['notify-send', '错误', error_msg])
        print(error_msg)
        exit(1)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("使用方法: python bookmarks.py [-l | -d <name> | <url>]")
        exit(1)

    if sys.argv[1] == "-l":
        list_bookmarks()
    elif sys.argv[1] == "-d":
        if len(sys.argv) != 3:
            print("使用方法: python bookmarks.py -d <name>")
            exit(1)
        delete_bookmark(sys.argv[2])
    else:
        url = sys.argv[1]
        add_bookmark(url)
