#!/bin/bash
# prints the most recent activity from the specified LOGFILE
# for a given number of unique IP addresses.

LOGFILE=$1
SELF_IP=${2:-192.168.1.1}
max_results=5
max_history=1000

if [ -z "$LOGFILE" ]; then
  echo "usage: $0 <log_file> [self_ip]"
fi

function unique_ips() {
  logs=$(grep --invert-match "$SELF_IP" "$LOGFILE" | tail -n $max_history | tac)
  ip_array=$(awk '{ print $1 }' <<< $logs | uniq | cat -n | sort +1 -u | sort -n | awk '{ print $2}')
  head -n $max_results <<< $ip_array | while read addr; do
    grep -m 1 -F --color $addr <<< $logs
    # Arch Linux dependencies: geoip geoip-database-extra
    geoip=$(geoiplookup $addr | grep --invert-match "GeoIP Country Edition")
    echo "$(tput dim)$geoip$(tput sgr0)"
  done
}

echo "Recent activity from $LOGFILE:"
unique_ips
