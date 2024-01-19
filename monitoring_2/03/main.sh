#!/bin/bash

source ../common/config.sh
source ../common/generator.sh
source logic.sh

if [[ $1 == 1 ]]; then
  clear_by_log_file
elif [[ $1 == 2 ]]; then
  echo "Введите две даты в формате YYYY-MM-DD HH:MM. Например: 2024-01-08 13:25"
  echo "Все найденные файлы, созданные в интервале между ними будут удалены"
  read -rp "Введите дату начала: " start_date
  echo "Дата начала: $start_date"
  read -rp "Введите дату окончания: " end_date
  clear_by_the_creation_date "$start_date" "$end_date"
elif [[ $1 == 3 ]]; then
  read -rp "Введите маску имени файла. Например: ab_110124: " name_mask
  clear_by_name_mask "$name_mask"
else
  echo -e "${FONT_RED}Ошибка!${DEF}"
  echo -e "${FONT_RED}Пример использования: bash main.sh 1${DEF}"
  echo -e "${FONT_RED}1 - Очистка файлов по лог файлу, находящемуся в папке /src/log/${DEF}"
  echo -e "${FONT_RED}2 - Очистка по дате создания файла${DEF}"
  echo -e "${FONT_RED}3 - Очистка по маске имени. Например: bash main.sh ab${DEF}"
fi

rm -rf ../log/
