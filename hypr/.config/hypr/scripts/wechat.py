#!/bin/env python
import json
import subprocess

proc = subprocess.run(
    ["hyprctl", "clients", "-j"],
    text=True,
    capture_output=True,
    check=True,
)

clients = json.loads(proc.stdout)

for c in clients:
    if c.get("class") == "wechat":
        ws = c.get("workspace", {})
        print(f"WeChat is running on workspace: {ws.get('name')} (id={ws.get('id')})")
        break
else:
    print("WeChat is not running")
    subprocess.run(["wechat"])
    exit(1)

current_ws_proc = subprocess.run(
    ["hyprctl", "activeworkspace", "-j"],
    text=True,
    capture_output=True,
    check=True,
)
current_ws = json.loads(current_ws_proc.stdout).get('id')
print("current ws: ", current_ws)

# move wechat
if current_ws == ws.get('id'):
    subprocess.run(["hyprctl", "dispatch", "movetoworkspacesilent", "special:wechat,class:wechat"])
else:
    subprocess.run(["hyprctl", "dispatch", "movetoworkspace", f"{current_ws},class:wechat"])
