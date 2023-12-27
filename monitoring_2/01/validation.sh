#!/bin/bash

STATUS_FLAG=1

function validate_arguments() {
  if [ $# != 6 ]; then
    echo -e "Module should be run with 6 parameters"
    echo -e "Example: bash main.sh /opt/test 4 az 5 az.az 3kb"
    else
      if ! [[ -e $1 ]]; then
        echo "Arguments validation: arguments #1 = $1"
        echo "Invalid path"
      elif ! [[ $2 =~ ^[1-9]{1,3}$ ]]; then
        echo "Arguments validation: argument #2 = $2"
        echo "number of folders should be only digits"
        echo "And no more then 999"
      elif ! [[ $3 =~ ^[a-zA-Z]{1,4}$ ]]; then
        echo "Arguments validation: argument #3"
        echo "only alphabetical characters are allowed in folder names = $3"
      elif ! [[ $4 =~ ^[1-9]{1,3}$ ]]; then
        echo "Arguments validation: argument #4 = $4"
        echo "number of files in directory should be only digits"
        echo "And no more then 999"
      elif ! [[ $5 =~ ^[a-zA-Z]{1,4}\.[a-zA-Z]{1,4}$ ]]; then
        echo "Arguments validation: argument #5 is invalid: $5"
        echo "Example: ab.cd"
      else

        if [ ${#6} -lt 3 ]; then
          echo "Arguments validation: argument #6"
          echo "Expression is too short. Enter more information"
        elif [ ${#6} -gt 5 ]; then
          echo "Arguments validation: argument #6"
          echo "Expression is too long"
        else
          number=${6:0:${#6}-2}
          extension=${6:${#6}-2:${#6}}

          if [[ $number =~ [^0-9+$] ]]; then
            echo "Arguments validation: argument #6"
            echo "should be number only with digits = ${number}"
          elif [ "$extension" != "Kb" ] && [ "$extension" != "kb" ] && [ "$extension" != "KB" ]; then
            echo "Arguments validation: argument #6"
            echo "file size must be in kilobytes"
          elif [[ $number -lt 1 ]] || [[ $number -gt 100 ]]; then
            echo "Arguments validation: argument #6"
            echo "number should be more then 1 and less then 100 = ${number}"

          else
            STATUS_FLAG=0
          fi
        fi
    fi
  fi
  if [ $STATUS_FLAG == 0 ]; then
    echo ${STATUS_FLAG}
  fi
}

function func_free_space() {
  free_space=$(df -k "$1" | tail -n 1 | awk '{print $4}')
  echo "${free_space}"
}

function free_space_check() {
  FLAG=0
  func_free_space "$1"
  if [[ ${free_space} -lt 1048576 ]]; then
    FLAG=1
  fi
  echo $FLAG
}