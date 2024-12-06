#!/bin/bash

if tmux has-session -t server 2>/dev/null; then
  tmux attach -t server
else 
  tmux new-session -d -s server

  tmux send-keys "ssh root@107.172.157.186" C-m
  tmux attach -t server
fi
