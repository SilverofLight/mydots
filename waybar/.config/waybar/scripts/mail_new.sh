#!/bin/bash

while true; do
dir1="$HOME/.Mail/account1/INBOX/new"
dir2="$HOME/.Mail/account1/Junk/new"

count1=$(find "$dir1" -maxdepth 1 -type f  | wc -l)
count2=$(find "$dir2" -maxdepth 1 -type f  | wc -l)

total=$((count1 + count2))

# echo $total > $HOME/Templates/mail_new
echo $total

sleep 60

done
