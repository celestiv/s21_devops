#!/bin/bash

source logic.sh

if [[ $# -ne 1 ]]; then
  echo -e "${FONT_RED}Ошибка! Введите параметр - число от 1 до 4. Пример: bash main.sh 2${DEF}"
elif [[ $1 -lt 1 || $1 -gt 4 ]]; then
  echo -e "${FONT_RED}Ошибка! Введите число от 1 до 4!${DEF}"
else
  sort_values "$1"
fi
