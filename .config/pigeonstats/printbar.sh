#!/bin/bash
# usage:
#
#     ./printbar.sh 45       # display a bar at 45 percent
#     ./printbar.sh 408 8191 # display a bar for a fraction

width=50
threshold=80
mode=bad

while getopts ":gbt:w:" opt; do
  case $opt in
  g   ) mode=good ;;
  b   ) mode=bad  ;;
  w   ) width=$OPTARG     ;;
  t   ) threshold=$OPTARG ;;
  \?  ) echo "Invalid option: -$OPTARG"
    exit 1 ;;
  esac
done
shift $((OPTIND-1))

percent=$1

if [ -n "$2" ]; then
  let percent=$1*100/$2
fi

let used_bar_width=($percent*$width)/100

red="$(tput setaf 1)"
green="$(tput setaf 2)"
if [ "$mode" = "bad" ]; then
  hi=$red
  low=$green
elif [ "$mode" = "good" ]; then
  hi=$green
  low=$red
fi

mode_color=$low
if [ "$percent" -ge "$threshold" ]; then
  mode_color=$hi
fi

function rep () {
  [ "$1" -lt "1" ] && return || \
    printf "${2:-=}%.0s" $(seq 1 $1)
}

tput sgr0
printf '['
printf "$mode_color"
rep $used_bar_width
tput sgr0
tput dim
rep $(($width-$used_bar_width))
tput sgr0
printf ']\n'
