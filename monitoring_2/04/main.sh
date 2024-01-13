#!/bin/bash

source ../common/config.sh
source logic.sh

echo -e "${FONT_GREEN}Started generating 5 log files"
for i in {1..5}
do
  random_day=$(( "RANDOM" % 30 + 1))
  random_month=$(( "RANDOM" % 12 + 1))
  if [[ $random_day -le 9 ]]; then
    random_day="0$random_day"
  fi
  if [[ $random_month -le 9 ]]; then
    random_month="0$random_month"
  fi
  log_filename="2023$random_month$random_day.log"
  touch $log_filename
  generate_logs $log_filename
done

echo -e "Successfully generated log files!${DEF}"