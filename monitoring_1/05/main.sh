#!/bin/bash

source info.sh

if [ $# != 1 ]
then
    echo "Нужно ввести адрес для сканирования"
else
    if [ ! -d $1 ]
    then
        echo "Директория не существует"
    elif [ ${1: -1} != "/" ]
    then
        echo "Адрес должен заканчиваться символом "/""
    else
        start_time=$(date +%s)
        info $1
        end_time=$(date +%s)
        echo "Время выполнения скрипта(сек): " $(($end_time-$start_time))
    fi
fi