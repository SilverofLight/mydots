import argparse
from PIL import Image
import pytesseract
import subprocess

def copy_to_clipboard(text):
    # 使用 wl-copy 复制到剪贴板
    process = subprocess.Popen(['wl-copy'], stdin=subprocess.PIPE)
    process.communicate(input=text.encode())

def main():
    # 创建命令行参数解析器
    parser = argparse.ArgumentParser(description="从图片中提取文字的 OCR 工具")
    parser.add_argument("image_path", help="输入图片的路径")
    parser.add_argument("--no-clipboard", action="store_true", help="不复制到剪贴板")

    # 解析命令行参数
    args = parser.parse_args()

    # 加载图片
    try:
        image = Image.open(args.image_path)
    except FileNotFoundError:
        print(f"文件未找到: {args.image_path}")
        return

    # 使用 Tesseract 提取文字
    extracted_text = pytesseract.image_to_string(image, lang="eng")

    # 打印提取的文字
    print("提取的文字如下：\n")
    print(extracted_text)

    # 复制到剪贴板
    if not args.no_clipboard:
        copy_to_clipboard(extracted_text)
        print("\n文字已复制到剪贴板")

if __name__ == "__main__":
    main()
