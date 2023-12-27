#!/bin/bash

function logic() {

  RAND=$(( "$RANDOM" % 100 ))

  DIR_NAMES=$(generate_name "$RAND" "$1" "$MIN_NAME_LEN" "$MAX_NAME_LEN")
  cur_date=$(date +"%d%m%y")
  FREE_SPACE=$(free_space_check /)
  for dir in $DIR_NAMES
    do
      mkdir -p "${dir}_${cur_date}"
      while IFS= read -r line; do
        number=${3:0:${#3}-2}
        FREE_SPACE=$(( "$FREE_SPACE" - "$number" ))
        if [[ "$FREE_SPACE" -le 1024 ]]; then
          break
        fi
        full_name="$(pwd)/${dir}_${cur_date}/$line"
        truncate -s "${number}M" "$full_name"
        echo "$full_name" >> "${LOG_DIR}/${cur_date}.log"
      done < <(generate_filenames "$RAND" "$2")
  done
}