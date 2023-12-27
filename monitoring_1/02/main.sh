#!/bin/bash

source info.sh
source echo.sh

function main() {
    if [ $# -ne 0 ]
    then
        echo "Скрипт работает без аргументов"
    else
        filename=$(date +"%d_%b_%Y_%H_%M_%S").status
        echoing
        read -p "Хотите сохранить изменения в файл?(y/n): " ANSWER
        if [[ $ANSWER == 'y' || $ANSWER == 'Y' ]]
        then
            echoing >> ${filename}
            echo "Файл ${filename} сохранен"
        else
            echo "Программа завершается"
        fi
    fi
}

main