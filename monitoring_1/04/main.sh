#!/bin/bash
source colors.conf
source colors.sh
source echo.sh
source ../02/info.sh

if [ $# != 0 ]
then
    echo "В части 4 не нужно вводить параметры. Задайте конфигурацию цветов в файле colors.conf"
else
    if [[ $column1_background != [0-6] ]]
    then
        column1_background=6;
    fi
    
    if [[ $column1_font_color != [0-6] ]]
    then
        column1_font_color=1;
    fi

    if [[ $column2_background != [0-6] ]]
    then
        column2_background=6;
    fi

    if [[ $column2_font_color != [0-6] ]]
    then
        column2_font_color=1;
    fi

    if [[ ( ${column1_background} == 6 ) && ( ${column1_font_color} == 1 ) && ( ${column2_background} == 6 ) && ( ${column2_font_color} == 1 )]]
    then
        echo "Column 1 background = default (black)"
        echo "Column 1 font color = default (white)"
        echo "Column 2 background = default (black)"
        echo "Column 2 font color = default (white)"
    fi
    
    if [[ ( ${column1_background} == ${column1_font_color} ) ||  ( ${column2_background} == ${column2_font_color} )]]
    then
        echo "Цвета фона и текста в одной колонке не должны совпадать, ведь так нельзя будет прочитать текст"
    else
        sys_info
        echoing
        echo_colors
    fi
fi
