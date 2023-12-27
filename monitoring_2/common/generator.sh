#!/bin/bash

function write_log_file() {
  echo "$1" >> "${LOG_DIR}"
}

function generate_name() {
  # input parameters:
  # $1 = number of names to generate
  # $2 = string with letters to create names from
  # $3 = minimum length of a name
  # $4 = maximum length of a name
  counter=0
  string="$2"
  base=""
  name=""
  for (( i=0; i<${#string}; i++ )); do
    char=${string:i:1}
    base+=${char}
    remain=${string:i+1:${#string}}
    temp_base=${base}
    while [[ ${counter} -lt $1 ]]; do
      name=${temp_base}${remain}
      if [[ ${#name} -gt "${MAX_NAME_LEN}" ]]; then
        exit 1
      fi
      if [[ ${#name} -ge "${MIN_NAME_LEN}" ]]; then
        (( counter++ ))
        echo "${name}"
      fi

    temp_base+=${char}
    done
    name=""

  done
}


function generate_filenames() {
  # input parameters
  # $1 = directory name
  # $2 = number of files to generate
  # $3 = letters to use in filenames

  local counter=0
  name=$(cut -d "." -f 1 <<< "$2")
  extension=$(cut -d "." -f 2 <<< "$2")

  gen_names=()
  while IFS= read -r line; do
    gen_names+=("$line")
  done < <(generate_name "$1" "$name" "${MIN_NAME_LEN}" "${MAX_NAME_LEN}")
  gen_extensions=()
  while IFS= read -r line; do
    gen_extensions+=("$line")
  done < <(generate_name "$1" "$extension" "${MIN_EXT_LEN}" "${MAX_EXT_LEN}")

  while [[ $counter -lt $1 ]]; do
    for i in "${gen_extensions[@]}"; do
      for j in "${gen_names[@]}"; do
        echo "$j.$i"
        (( counter++ ))
      done
    done
  done
  counter=0
}