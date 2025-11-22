#!/bin/bash

cd ~/Study/Obsidian/
date=$(date +%Y-%m-%d-%H-%M-%S)

if [ -n "$(git status -s)" ]; then
  echo "Backuping..."
  git add .
  git commit -m "Obsidian Backup: $date"
  git push
fi
