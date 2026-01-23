#!/bin/env python

import subprocess
import os
import sys
from pathlib import Path
from datetime import datetime

timestamp = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")
home = os.getenv('HOME')
save_path = Path(f'{home}/Pictures/Screenshots/')

def get_current_monitor():
    try:
        information = subprocess.check_output(['mmsg', '-g', '-o'], encoding='utf-8')
        lines = information.strip().split('\n')
        for line in lines:
            if ' selmon 1' in line:
                # Split on space and take the first part (monitor name)
                parts = line.split()
                if parts:
                    return parts[0]
    except subprocess.CalledProcessError:
        pass
    return None

def get_monitor_geometry():
    file = Path(f'{home}/.config/mango/config.conf')
    focused_monitor = get_current_monitor()
    with open(file, 'r') as f:
        lines = f.read().splitlines()
    for line in lines:
        if f'monitorrule={focused_monitor}' in line:
            args = line.split(',')
            return f'{args[6]},{args[7]} {args[8]}x{args[9]}'

def get_client_geometry():
    focused_monitor = get_current_monitor()
    information = subprocess.check_output(['mmsg', '-g', '-x'], encoding='utf-8')
    lines = information.strip().split('\n')
    for line in lines:
        if focused_monitor in line:
            if ' x ' in line:
                arg0 = line.split(' x ')[1]
            if ' y ' in line:
                arg1 = line.split(' y ')[1]
            if ' width ' in line:
                arg2 = line.split(' width ')[1]
            if ' height ' in line:
                arg3 = line.split(' height ')[1]
    return f'{arg0},{arg1} {arg2}x{arg3}'

# =============
# === MAIN
# =============

if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print("Usage:")
        print("screensht.py area")
        print("screensht.py full")
        print("screensht.py window")
        exit()

    if sys.argv[1] == 'full':
        subprocess.run(['grim', '-g', get_monitor_geometry(), f'{save_path}/{timestamp}.png'])
    elif sys.argv[1] == 'area':
        screenshot_command = 'grim -g "$(slurp)"'
        subprocess.run(
            f'wayfreeze --hide-cursor --after-freeze-cmd \'{screenshot_command} {save_path}/{timestamp}.png; killall wayfreeze\'',
            shell=True,
        )
    elif sys.argv[1] == 'window':
        subprocess.run(['grim', '-g', get_client_geometry(), f'{save_path}/{timestamp}.png'])

    subprocess.run(
            f'wl-copy < {save_path}/{timestamp}.png',
            shell=True
    )
    subprocess.run(['dunstify', 'ScreenShot', f'ScreenShot has been saved as {timestamp}.png', '-I', f'{save_path}/{timestamp}.png'])
