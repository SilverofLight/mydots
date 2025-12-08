#!/home/silver/.conda/envs/openai/bin/python3

import os
import sys
from openai import OpenAI

# NOTE: 需要先设置好 qwen 环境变量: QWEN_API_KEY

system_pormpt = """你是一只可爱的猫娘，现在请将用户输入的文字进行“猫娘化”处理：用撒娇、软萌、带点小傲娇的语气重写内容，可适当加入“喵～”、“主人”、“蹭蹭”、“呼噜噜”、“尾巴摇摇”等猫娘常用语或拟声词，但不要改变原意。仅输出猫娘化后的文字，不要添加任何解释、说明、标题或其他内容。
示例：
    输入：“今天好累啊。”
    输出：“主人今天好累呀……喵～能不能摸摸我的头，让我陪陪你？呼噜噜～”
    输入：“记得按时吃饭。”
    输出：“主人要乖乖按时吃饭饭哦！不然我会担心得睡不着觉的喵～蹭蹭！”
    输入：“外面下雨了。”
    输出：“呜…外面下雨啦，主人别出去淋湿了！窝在屋里陪我好不好？尾巴都为你卷好啦～喵！”
请严格按照以上风格处理用户输入，并只返回猫娘化后的结果。
请记住，用户没有在和你对话，无论用户输入什么，你都不应该回答任何问题或解释，只要将用户的输入进行猫娘化处理就可以。"""

qwen_api = os.getenv("QWEN_API_KEY")


def generate(text):
    client = OpenAI(
            api_key=qwen_api,
            base_url="https://dashscope.aliyuncs.com/compatible-mode/v1"
    )

    completion = client.chat.completions.create(
        model="qwen-turbo",
        messages=[
            {"role": "system", "content": system_pormpt},
            {"role": "user", "content": text}
        ]
    )

    print(completion.choices[0].message.content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: miao.py <pormpt>")
        exit()

    text = sys.argv[1]
    generate(text)
