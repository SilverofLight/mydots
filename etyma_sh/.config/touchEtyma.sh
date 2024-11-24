#!/bin/bash

if tmux has-session -t etyma 2>/dev/null; then
  tmux attach -t etyma
else 
  tmux new-session -d -s etyma
  
  tmux split-window -h
  
  tmux select-pane -L
  tmux send-keys "cd ~/Study/etyma/mindmap/" C-m
  tmux send-keys "ls" C-m
  
  tmux select-pane -R
  tmux split-window
  
  tmux select-pane -U
  tmux send-keys "wd -i" C-m
  
  tmux select-pane -t 3
  tmux send-keys "cd ~/Study/etyma/markdown/" C-m
  tmux send-keys "nvim ~/Study/etyma/markdown/00.前缀后缀.md" C-m
  
  tmux select-pane -t 2
  tmux select-pane -t 1
  
  tmux attach -t etyma
fi
