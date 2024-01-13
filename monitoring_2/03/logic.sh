#!/bin/bash

function clear_by_log_file() {
  echo -e "${FONT_GREEN}Removing files and directories from log file"
  log_path="../log/"
  cd "$log_path" || exit
  log_file=$(ls)
  while IFS= read -r line
  do
    file_path=$(echo "$line" | awk '{print $2}')
    if [ -f "$file_path" ]; then
      rm -f "$file_path"
      dir_path=${file_path%/*}
      if [ ! "$(ls -A "$dir_path")" ]; then
        rmdir "$dir_path"
      fi
    fi
  done < "$log_file"
  echo -e "Finished removing${DEF}"
}

function clear_by_the_creation_date() {
  echo -e "${FONT_GREEN}Removing files and directories by creation date and time${DEF}"

  date_start=$(echo "$1" | awk '{print $1}')
  time_start=$(echo "$1" | awk '{print $2}')
  date_end=$(echo "$2" | awk '{print $1}')
  time_end=$(echo "$2" | awk '{print $2}')
  seconds_start=$(date -d "$date_start $time_start" +%s)
  seconds_end=$(date -d "$date_end $time_end" +%s)
  dirs_to_remove=$(find "$SOURCE_DIR" -type d -executable | grep -v -e bin -e sbin -e proc)
  for dirs_path in $dirs_to_remove
  do
    time_created=$(stat -c %y "$dirs_path" | awk '{print $2}' | cut -d "." -f 1)
    date_created=$(stat -c %y "$dirs_path" | awk '{print $1}')
    seconds=$(date -d "$date_created $time_created" +%s)
    if [[ "$seconds" -ge "$seconds_start" && "$seconds" -le "$seconds_end" ]]; then
        rm -rf "$dirs_path"
    fi
  done
  echo -e "${FONT_GREEN}Finished removing${DEF}"
}

function clear_by_name_mask() {
  echo -e "${FONT_GREEN}Removing files and directories by name mask"
  name=$(echo "$1" | cut -d "_" -f 1)
  cur_date=$(echo "$1" | cut -d "_" -f 2)
  regex="^[a-zA-Z]{1,7}"
  if [[ name =~ $regex ]]; then
    DIR_NAMES=$(generate_name 100 "$name" "$MIN_NAME_LEN" "$MAX_NAME_LEN")
    for dir in $DIR_NAMES
    do
      full_name="${dir}_${cur_date}"
      find "$SOURCE_DIR" -type d -name "*$full_name*" -exec rm -rf {} \;
    done
  fi
  echo -e "Finished removing${DEF}"
}