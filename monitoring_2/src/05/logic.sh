#!/bin/bash

function sort_values() {
  for i in ../04/*.log
  do
    name_part=$(echo "$i" | cut -d "/" -f 3 | cut -d "." -f 1)
    if [[ $1 -eq 1 ]]; then
      awk '{print $9}' "$i" | sort -k 9,9n > "./${name_part}_sorted_by_response_code.log"
    elif [[ $1 -eq 2 ]]; then
      awk '{print $1}' "$i" | uniq > "./${name_part}_unique_ip_addresses.txt"
    elif [[ $1 -eq 3 ]]; then
      awk '{print $9 " " $0}' "$i" | grep -E '^4|^5' > "./${name_part}_error_codes_entries.txt"

    elif [[ $1 -eq 4 ]]; then
      awk '{print $1}' "./${name_part}_error_codes_entries.txt" | uniq > "./${name_part}_unique_ip_with_errors.txt"
    fi
  done
}
