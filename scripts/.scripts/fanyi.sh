#!/bin/bash

while true; do
    if ! read -r -p "> " msg; then
        echo "exit"
        exit 0
    fi
    
    if [ -n "$msg" ]; then
        fanyi "$msg"
    fi
done
