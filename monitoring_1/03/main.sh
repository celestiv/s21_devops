#!/bin/bash

source colors.sh
source ../02/info.sh

if [ $# == 0 ]
then
    echo "Нужно вести параметры"
elif [ $# -lt 4 ]
then
    echo "Нужно ввести 4 параметра"
elif [ $# -gt 4 ]
then
    echo "Нужно ввести 4 параметра"
else
    for color in $@
    do
        if [[ (( $color != [1-6]) || ( color -lt 1 ) || ( $color -gt 6 )) ]]
        then
            echo "Параметры должны быть числами от 1 до 6"
            exit 1
        else
            if [[ ( $1 -eq $2 ) || ( $3 -eq $4 ) ]]
            then
                echo "Цвета фона и текста в одной колонке не должны совпадать, ведь так нельзя будет прочитать текст"
                exit 1

            fi
        fi
    done
    sys_info
    echoing $1 $2 $3 $4
fi