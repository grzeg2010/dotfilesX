#!/bin/bash
# beware: duct tape programming

if [ -n "$PIGEON_TITLE" ]; then
  tput sgr0
  tput bold
  printf "%s\n\n" "Hardware Temperatures"
  tput sgr0
fi

if [ "$1" = "--oneline" ]; then
  oneline=y
  HARD_DISK=$2
else
  HARD_DISK=$1
fi

clear=$(tput sgr0)

function tcolor () {
  if [ "$1" -ge "$2" ]; then
    color=$(tput setab 196)
  elif [ "$1" -ge "$3" ]; then
    color=$(tput setab 3)
  elif [ "$1" -ge "$4" ]; then
    color=$(tput setab 2)
  else
    color=$(tput setab 6)
  fi
}

# attempt to use smartctl or hddtemp
function hdd_temp () {
  if which smartctl jq > /dev/null 2>&1; then
    local temp=$(smartctl -Aj $1 | jq .temperature.current)
    if [[ "$temp" =~ '^[0-9]+$' ]]; then
      echo $temp
      return
    fi
  fi
  if which sudo hddtemp > /dev/null 2>&1; then
    local temp=$(sudo -n -- hddtemp -n $1 2>&1)
    echo $temp
    if [[ "$temp" =~ ^[0-9]+$ ]]; then
      return
    else
      return 1
    fi
  fi
  return 1
}


if temp=$(hdd_temp $HARD_DISK); then
  tcolor $temp 50 40 25
  printf " $color%s %s°C $clear" "$HARD_DISK" "$temp"
  if [[ -v oneline ]]; then
    printf " "
  else
    printf "\n"
  fi
elif [[ "$temp" = *"sleep"* ]]; then
  echo "$temp"
fi

cpu_temps=""
col=0
sensors_output=$(sensors -uA 2> /dev/null)


while read -r core_name; do
  temp=$(printf "$sensors_output" | grep -A1 "$core_name" | awk '{if(/_input:/) print $2}')
  temp=$(printf "%.1f" "$temp")
  tcolor $(echo $temp | cut -f1 -d".") 70 60 25
  cpu_temps="${cpu_temps} $color CORE $(echo $core_name | tr -dc '0-9') $temp$celcius $clear "

  # print four cores per row
  if [[ ! -v oneline ]]; then
    ((col++))
    if [ "$col" -ge "4" ]; then
      printf "\n%s\n" "${cpu_temps}"
      cpu_temps=""
    fi
  fi
done <<< $(printf "$sensors_output" | grep Core)

if [ -n "$cpu_temps" ]; then
  if [[ -v oneline ]]; then
    spacing="%s"
  else
    spacing="\n%s\n"
  fi
  printf "$spacing" "$cpu_temps"
fi

