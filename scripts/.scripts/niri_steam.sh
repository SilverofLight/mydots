#!/bin/bash

export WINE_FULLSCREEN_INTEGER_SCALING=1
export DISPLAY=:20
Xwayland :20 -geometry 1920x1080 &
steam &
