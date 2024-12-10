#!/bin/bash

# author: Silver Lee
# date: 2024/12/5
# description: use tmux to open my server
# requirements: tmux

if tmux has-session -t server 2>/dev/null; then
  tmux attach -t server
else 
  tmux new-session -d -s server

  tmux send-keys "ssh root@107.172.157.186" C-m
  tmux attach -t server
fi
