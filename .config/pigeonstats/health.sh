#!/bin/bash

clear=$(tput sgr0)
inactive="$(tput setaf 1)${PIGEON_SERVICE_INACTIVE:-▲ inactive}$clear"
active="$(tput setaf 2)${PIGEON_SERVICE_ACTIVE:-● active}$clear"


if [ "$#" -lt 2 ]; then
  echo "usage: $0 {systemd|web|sql} NAME SERVICE [EXPECTED]"
  exit 1
fi

case $1 in
  s|service)
    systemctl is-active --quiet $3 ;;
  h|http)
    [ "$(curl --http2 --silent --max-time 2 --output /dev/null --head -w '%{http_code}' "$3")" -eq "${4:-200}" ] ;;
  sql)
    mysql --execute='SELECT 1' --silent --quick > /dev/null 2>&1 ;;
esac


if [ "$?" = "0" ]; then
  result=$active
else
  result=$inactive
fi

printf "%-12s %24s" "$2:" "$result"

