#!/bin/bash

echo -e "\033[94mWelcome to kd!\033[0m"

while true; do
    if ! read -r -p "> " msg; then
        echo "exit"
        exit 0
    fi

    if [ "$msg" = "clear" ] || [ "$msg" = "c" ]; then
        clear
        echo -e "\033[94mWelcome to kd!\033[0m"
        continue
    fi
    
    if [ -n "$msg" ]; then
        # 第一行为红色，第二行如果是注音，则为绿色，倒数第二行为红色
        kd "$msg" | sed -e 's/    \[/\n    [/g' -e '/⸺⸺⸺⸺⸺/q' \
        | awk 'NR==1 {print "\033[31m" $0 "\033[0m"; next} 
               NR==2 {print; next} 
               {prev=line; line=$0; lines[NR]=$0} 
               END {
                   if (NR > 1) {lines[NR-1]="\033[31m" prev "\033[0m"}
                   for (i=3; i<NR; i++) print "  " lines[i]
                   if (NR >= 1) print line
               }' \
        | sed -e 's/\[\([^]]*\)\]/\x1b[92m[\1]\x1b[0m/g'
    fi
done
