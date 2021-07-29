#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <domain_name> <expiration_date>"
  echo "example: $0 sozy.me \"June 30, 2021\""
  exit 1
fi

clear="$(tput sgr0)"
echo "$(tput smul)$1$clear domain name expires in $(tput setaf 3)$((($(date -d "$2" +%s) - $(date +%s)) / 86400))$clear days. $(tput dim)(namecheap.com)$(tput sgr0)";

