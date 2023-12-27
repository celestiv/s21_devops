#!/bin/bash

source ../common/validation.sh
source ../common/config.sh
source ../common/generator.sh
source logic.sh

OUTPUT=""
OUTPUT+=$(validate_folder_names "$1")
OUTPUT+=$(validate_file_names "$2")
OUTPUT+=$(validate_file_size "$3")

if [ "$OUTPUT" != "" ]; then
  echo -e "${FONT_RED}$OUTPUT${DEF}"
  echo -e "${FONT_RED}====== Input arguments are invalid. Try again ======${DEF}"
  exit 1
fi
echo -e "${FONT_GREEN}Input arguments are good${DEF}"

FREE_SPACE=$(free_space_check /)
if [[ "$FREE_SPACE" -le 1048576 ]];then
  echo -e "${FONT_RED}No space left in root: ${FREE_SPACE} kilobytes${DEF}"
  exit 1
fi
echo -e "${FONT_GREEN}There is enough free space: ${FREE_SPACE} kilobytes${DEF}"

START_TIME=$(date +"%s")
echo -e "${FONT_GREEN}Started script execution${DEF}"

logic "$@"

END_TIME=$(date +"%s")
echo -e "${FONT_GREEN}Script execution time: $((END_TIME - START_TIME)) seconds${DEF}"