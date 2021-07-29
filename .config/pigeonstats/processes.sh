#1/bin/bash

printf "$(tput bold)%s$(tput sgr0)%22s\n\n" "Processes" "$(ps -A --no-headers | wc -l) running"
ps -Ao comm,pid,pcpu,tty --sort=-pcpu | head -n 6

