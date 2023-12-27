#!/bin/bash


function validate_path() {
  if ! [[ -e $1 ]]; then
    echo -e "Arguments validation: validate path: arguments #1 = $1\n"
    echo -e "Invalid path\n"
  fi

}

function validate_numbers() {
  if [[ $1 =~ [^0-9$]{1-3} ]]; then
    echo -e "Arguments validation: validate numbers: Wrong numbers format for $1\n"
  fi
}

function validate_folder_names() {
  # $1 = string to check. Example: "ab"
  if [[ ${#1} -lt $MIN_EXT_LEN ]] || [[ ${#1} -gt $MAX_NAME_LEN ]]; then
    echo -e "Arguments validation: Folder name should be between $MIN_EXT_LEN and $MAX_NAME_LEN\n"
  else
    if ! [[ $1 =~ $REGEX ]]; then
      echo -e "Arguments validation: argument #3\n"
      echo -e "only alphabetical characters are allowed in folder names = $1\n"
#    else
#      echo 0
    fi
  fi
}


function validate_file_names() {
  # $1 = string to check. Example: "ab.cd"
  name=$(cut -d "." -f 1 <<< "$1")
  extension=$(cut -d "." -f 2 <<< "$1")
  if [[ ${#name} -le $MIN_EXT_LEN ]] || [[ ${#name} -gt $MAX_NAME_LEN ]]; then
    echo -e "Arguments validation: File name should be between $MIN_EXT_LEN and $MAX_NAME_LEN\n"
  elif [[ ${#extension} -le $MIN_EXT_LEN ]] || [[ ${#extension} -gt $MAX_EXT_LEN ]]; then
    echo -e "Arguments validation: File extension should be between $MIN_EXT_LEN and $MAX_EXT_LEN\n"
  else
    if ! [[ $name =~ $REGEX ]] || ! [[ $extension =~ $REGEX ]]; then
      echo -e "Arguments validation: should be only letters from a-z or A-Z\n"
      echo -e "Example: ab.cd\n"
#    else
#      echo 0
    fi
  fi
}


function validate_file_size() {
  # $1 = size of a file. Example: "99Mb"
  if [ ${#1} -lt 3 ]; then
    echo -e "Arguments validation: argument #6\n"
    echo -e "Expression is too short. Enter more information\n"
  elif [ ${#1} -gt 5 ]; then
    echo -e "Arguments validation: argument #6\n"
    echo -e "Expression is too long\n"
  else
    number=${1:0:${#1}-2}
    extension=${1:${#1}-2:${#1}}
    if [[ $number =~ [^0-9+$] ]]; then
      echo -e "Arguments validation: argument #6\n"
      echo -e "should be number only with digits = ${number}\n"
    elif [ "$extension" != "Mb" ] && [ "$extension" != "mb" ] && [ "$extension" != "MB" ]; then
      echo -e "Arguments validation: argument #6\n"
      echo -e "file size must be in kilobytes\n"
    elif [[ $number -lt 1 ]] || [[ $number -gt 100 ]]; then
      echo -e "Arguments validation: argument #6\n"
      echo -e "number should be more then 1 and less then 100 = ${number}\n"
#    else
#      echo 0
    fi
  fi
}

function free_space_check() {
  free_space=$(df -k "$1" | tail -n 1 | awk '{print $4}')
  echo "$free_space"
}