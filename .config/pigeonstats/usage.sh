#!/bin/bash

source_dir="$(dirname "$(readlink -f "$0")")"
function printbar () {
  if which printbar.sh > /dev/null 2>&1; then
    printbar.sh $@
  else
    $source_dir/printbar.sh $@
  fi
}

# mountpoint usage bars

#df_info="$(df -hl 2> /dev/null)"
#head -n 1 <<< " $df_info"
#
#for point in "$@"; do
#  line=$(grep -m 1 $point <<< "$df_info")
#  
#  usage_percent=$(echo "$line" | awk '{print $5;}' | sed 's/%//')
#
#  # btrfs volumes will have subvolumes mounted in different places
#  # it doesn't make sense to display mountpoint
#  if [ "$(mount | grep $point | wc -l)" -gt "1" ]; then
#    fstype=$(df -T 2> /dev/null | grep -m 1 $point | awk '{print $2}')
#    line="$(sed "s/% \/.*\$/% [$fstype]/" <<< "$line")"
#  fi
#
#  echo " $line"
#  printbar $usage_percent
#done

# memory bars

printf "\n"

function memory () {

  local free_info=$(free -m | grep $1)
  local mem_total=$(echo $free_info | awk '{print $2;}')
  local mem_used=$(echo $free_info | awk '{print $3;}')
  printf "%-21s%31s\n" " $2" "$mem_used / $mem_total"
  printbar $mem_used $mem_total
}

memory "Pamięć" "Pamięć"
memory "Wymiana" "Swap"
