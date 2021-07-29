#!/bin/bash

source_dir="$(dirname "$(readlink -f "$0")")"
function printbar () {
  if which printbar.sh > /dev/null 2>&1; then
    printbar.sh $@
  else
    $source_dir/printbar.sh $@
  fi
}

cd /sys/class/power_supply/BAT[0-9]/

if [ -f energy_now ]; then
  now=$(< energy_now)
  full=$(< energy_full)
elif [ -f charge_now ]; then
  now=$(< charge_now)
  full=$(< charge_full)
fi

printf " $(tput bold)%-20s$(tput sgr0)%31s\n" "$(< type)" "$(< technology)"
printf " %-20s%31s\n" "$(< status)" "$now / $full"
printbar -g -t 50 $now $full
