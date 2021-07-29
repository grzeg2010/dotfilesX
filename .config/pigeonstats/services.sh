#!/bin/bash
# This file is just an example, copy it somewhere outside the
# repo folder and customize to your system

function health () {
  ./health.sh "$@"
}

printf "$(tput bold)Services$(tput sgr0)\n\n"

printf " "
health service Firewall ufw
printf "    "
health sql     MariaDB
echo

printf " "
health http    Nextcloud https://cloud.sozy.me/status.php 200

printf "    "
health http    Ackee     https://ackee.sozy.me/tracker.js 204
echo

