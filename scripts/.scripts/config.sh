#!/bin/bash

if [ -n "$TMUX" ]; then
  tmux new-window -n "config"
  tmux send-keys -t config "cd ~/mydots/" C-m
  tmux send-keys -t config "ra" C-m
else

  if tmux has-session -t config 2>/dev/null; then
    tmux attach -t config
  else 
    tmux new-session -d -s config
  
    tmux send-keys -t config "cd ~/mydots/" C-m
    tmux send-keys -t config "ra" C-m
  
    tmux attach-session -t config
  fi

fi
