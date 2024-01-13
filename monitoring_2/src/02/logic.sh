#!/bin/bash

function clogging_logic() {
  RAND=$(( "$RANDOM" % 100 ))
  FREE_SPACE=$(free_space_check /)
  cd ..
  PROJECT_DIR="$(pwd)"
  mkdir log
  touch "${LOG_DIR}${CUR_DATE}.log"
  while [ "$FREE_SPACE" -ge "$SIZE_LIMIT" ]; do
    random_clogging "$@"
    FREE_SPACE=$(free_space_check /)
  done
}

function random_clogging() {
  avail_dirs=$(find "$SOURCE_DIR" -type d -executable)
  for avail_dir in $avail_dirs
    do
    cd "$avail_dir" || exit
    DIR_NAMES=$(generate_name "$RAND" "$1" "$MIN_NAME_LEN" "$MAX_NAME_LEN")
    for dir in $DIR_NAMES
      do
        mkdir -p "${dir}_${CUR_DATE}"
        while IFS= read -r line; do
          number=${3:0:${#3}-2}
          full_name="$(pwd)${dir}_${CUR_DATE}/$line"
          fallocate -l "${number}M" "$full_name"
          echo "FILE_PATH: $full_name CREATION_DATE: $CUR_DATETIME FILE_SIZE: $3" >> "${PROJECT_DIR}${LOG_DIR}${CUR_DATE}.log"
          FREE_SPACE=$(free_space_check /)
          if [[ "$FREE_SPACE" -le "$SIZE_LIMIT" ]]; then
            exit 1
          fi
        done < <(generate_filenames "$RAND" "$2")
    done
  done
}