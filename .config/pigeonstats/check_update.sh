#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <github repo> <version>"
  echo "example: $0 electerious/Ackee \"v1.7.1\""
  exit 1
fi

function check_update_from_github () {
  local repo=$1
  local current_version=$2
  local latest_version=$(curl -s https://api.github.com/repos/$repo/releases/latest | jq --raw-output .name)
  if [ "$current_version" != "$latest_version" ]; then
    echo "A newer version for $(tput bold)$repo$(tput sgr0) is available on Github."
    current_version="$(tput setaf 1)$current_version$(tput sgr0) $(tput dim)(current)$(tput sgr0)"
    latest_version="$(tput setaf 2)$latest_version$(tput sgr0) $(tput dim)(latest)$(tput sgr0)"
    echo "$current_version --> $latest_version"
  fi
}

check_update_from_github $1 $2


