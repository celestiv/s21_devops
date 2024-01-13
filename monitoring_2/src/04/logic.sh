#!/bin/bash

function generate_logs() {
  entries_number=$(( "RANDOM" % (1000 - 100 + 1) + 100 ))
  counter=0
  while [[ counter -le $entries_number ]]; do
    random_status_code=$(( "RANDOM" % ${#RESPONSE_CODES[@]} ))
    random_bytes=$(( "RANDOM" ))
    random_website_index=$(( "RANDOM" % ${#WEBSITES[@]}))
    random_agent_index=$(( "RANDOM" % ${#AGENTS[@]}))

    file_date=$(echo "$1" | cut -d "." -f 1 )
    file_unix_time=$(date -d "$file_date" +'%s')
    file_unix_time=$(( "$file_unix_time" + counter))

    echo -e "$(generate_ip) - - [$(date -d "@$file_unix_time" +'%d/%b/%Y:%H:%M:%S %z')] \"$(generate_response_code)\" ${RESPONSE_CODES[$random_status_code]} $random_bytes \"${WEBSITES[$random_website_index]}\" \"${AGENTS[$random_agent_index]}\"" >> "$1"
    counter=$(( "$counter" + 1 ))
  done
}

function generate_ip() {
  output_ip=$(( "RANDOM" % 256 ))
  for i in {1..3}; do
    rand_octet=$(( "RANDOM" % 256 ))
    output_ip+=".$rand_octet"
  done
  echo "$output_ip"
}

function generate_response_code() {
  random_method_index=$(( "RANDOM" % ${#METHODS[@]}))
  random_http_type_index=$(( "RANDOM" % ${#HTTP_TYPES[@]}))

  echo "${METHODS[$random_method_index]} /index.html ${HTTP_TYPES[random_http_type_index]}"
}
