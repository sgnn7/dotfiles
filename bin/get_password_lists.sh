#!/bin/bash -e

ENDPOINTS=("https://downloads.skullsecurity.org/passwords/"
           "https://downloads.skullsecurity.org/passwords/passwords/")

for endpoint in ${ENDPOINTS[@]}; do
  lists=$(curl ${endpoint} | grep bz2 | awk -F\" '{print $2}')
  for link in ${lists}; do
    if [[ -f ${link} ||
          ${link} =~ facebook-names ||
          ${link} =~ skullsecurity-lists ]]; then
      echo "Skippig ${link}"
      continue
    fi

    wget ${endpoint}${link}
  done
done
