#!/bin/bash

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
      (( counter++ ))

      name=${temp_base}${remain}
      if [[ ${#name} -ge $3 ]]; then
        echo "${name}"
      fi
      if [[ ${#name} -eq $4 ]]; then
        exit 1
      fi
    temp_base+=${char}
    done
    name=""
  done
}


function generate_filenames() {
  dirname=$1
  counter=0
  name=$(cut -d "." -f 1 <<< "$3")
  extension=$(cut -d "." -f 2 <<< "$3")
  echo "name = ${name}"
  echo "extension = ${extension}"
  gen_names=()
  while IFS= read -r line; do
    gen_names+=("$line")
  done < <(generate_name "$2" "$name" 4 7)
  gen_extensions=()
  while IFS= read -r line; do
    gen_extensions+=("$line")
  done < <(generate_name "$2" "$extension" 1 3)

  while [[ $counter -lt $2 ]]; do
    for i in "${gen_names[@]}"; do
      for j in "${gen_extensions[@]}"; do
        echo "${dirname}/$i.$j"
        (( counter++ ))
      done
    done
  done
}

echo -e "$(generate_filenames "$@")"
