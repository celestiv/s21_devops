#!/bin/bash

function logic() {
  DIR_NAMES=$(generate_name "$2" "$3" "$MIN_NAME_LEN" "$MAX_NAME_LEN")

  FREE_SPACE=$(free_space_check /)
  PROJECT_DIR=$(pwd)/../
  mkdir -p "$PROJECT_DIR$LOG_DIR"
  touch "$PROJECT_DIR$LOG_DIR$CUR_DATE.log"

  cd "$1" || exit
  for dir in $DIR_NAMES
    do
      mkdir -p "$(pwd)/${dir}_${CUR_DATE}"
      while IFS= read -r line; do
        number=${6:0:${#6}-2}
        full_name="$(pwd)/${dir}_${CUR_DATE}/$line"
        truncate -s "${number}K" "$full_name"
        echo "FILE_PATH: $full_name CREATION_DATE: $CUR_DATETIME FILE_SIZE: $6" >> "$PROJECT_DIR${LOG_DIR}${CUR_DATE}.log"
        FREE_SPACE=$(( "$FREE_SPACE" - "$number" ))
        if [[ "$FREE_SPACE" -le 1048576 ]]; then
          break
        fi
      done < <(generate_filenames "$4" "$5")
  done
}