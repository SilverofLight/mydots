#!/bin/bash

bv=$(wofi --dmenu --prompt "Bv")

mpv --quiet --no-terminal --title="mpv-bilibili" https://www.bilibili.com/video/$bv
