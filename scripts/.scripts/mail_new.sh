#!/bin/bash

dir1="$HOME/.Mail/account1/INBOX/new/"
dir1="$HOME/.Mail/account1/Junk/new/"

count1=$(find "$dir1" -maxdepth 1 -type f 2>/dev/null | wc -l)
count1=$(find "$dir2" -maxdepth 1 -type f 2>/dev/null | wc -l)

total=$((count1 + count2))

echo $total > $HOME/Templates/mail_new
