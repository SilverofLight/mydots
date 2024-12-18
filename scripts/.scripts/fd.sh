#!/bin/bash

while true; do
    if ! read -r -p "> " msg; then
        echo "exit"
        exit 0
    fi

    if [ "$msg" = "clear" ] || [ "$msg" = "c" ]; then
        clear
        continue
    fi
    
    if [ -n "$msg" ]; then
        kd "$msg"
    fi
done
