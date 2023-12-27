#!/bin/bash

function init_colors() {
    D="\033[0m"

    VALUE=$(set_back_color ${column1_background})
    LEFT_BACK="\033[${VALUE}m"

    VALUE=$(set_text_color ${column1_font_color})
    LEFT_TEXT="\033[${VALUE}m"

    VALUE=$(set_back_color ${column2_background})
    RIGHT_BACK="\033[${VALUE}m"

    VALUE=$(set_text_color ${column2_font_color})
    RIGHT_TEXT="\033[${VALUE}m"
}

function set_text_color() {
    local VALUE=0

    case "$1" in
        1) VALUE=37 ;;
        2) VALUE=31 ;;
        3) VALUE=32 ;;
        4) VALUE=34 ;;
        5) VALUE=35 ;;
        6) VALUE=30 ;;
    esac
    if [ ${VALUE} == 0 ]
    then
        VALUE=37
    fi

    echo $VALUE
}

function set_back_color() {
    local VALUE=0

    case "$1" in
        1) VALUE=47 ;;
        2) VALUE=41 ;;
        3) VALUE=42 ;;
        4) VALUE=44 ;;
        5) VALUE=45 ;;
        6) VALUE=40 ;;
    esac
    if [ ${VALUE} == 0 ]
    then
        VALUE=40
    fi

    echo $VALUE
}

function echo_colors() {
    echo ""
    case $column1_background in
        1) echo "Column 1 background = 1 (white)" ;;
        2) echo "Column 1 background = 2 (red)" ;;
        3) echo "Column 1 background = 3 (green)" ;;
        4) echo "Column 1 background = 4 (blue)" ;;
        5) echo "Column 1 background = 5 (purple)" ;;
        6) echo "Column 1 background = 6 (black)" ;;
    esac

    case $column1_font_color in
        1) echo "Column 1 font color = 1 (white)" ;;
        2) echo "Column 1 font color = 2 (red)" ;;
        3) echo "Column 1 font color = 3 (green)" ;;
        4) echo "Column 1 font color = 4 (blue)" ;;
        5) echo "Column 1 font color = 5 (purple)" ;;
        6) echo "Column 1 font color = 6 (black)" ;;
   esac

    case $column2_background in
        1) echo "Column 2 background = 1 (white)" ;;
        2) echo "Column 2 background = 2 (red)" ;;
        3) echo "Column 2 background = 3 (green)" ;;
        4) echo "Column 2 background = 4 (blue)" ;;
        5) echo "Column 2 background = 5 (purple)" ;;
        6) echo "Column 2 background = 6 (black)" ;;
   esac

    case $column2_font_color in
        1) echo "Column 2 font color = 1 (white)" ;;
        2) echo "Column 2 font color = 2 (red)" ;;
        3) echo "Column 2 font color = 3 (green)" ;;
        4) echo "Column 2 font color = 4 (blue)" ;;
        5) echo "Column 2 font color = 5 (purple)" ;;
        6) echo "Column 2 font color = 6 (black)" ;;
   esac
}