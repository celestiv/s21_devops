#!/bin/bash

function echoing() {
    init_colors $1 $2 $3 $4
    echo -e "${LEFT_BACK}${LEFT_TEXT}HOSTNAME        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$HOSTNAME${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}TIMEZONE        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$TIMEZONE${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}USER            ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$USER${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}OS              ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$OS${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}DATE            ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$DATE${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}UPTIME          ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$UPTIME${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}UPTIME_SEC      ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$UPTIME_SEC${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}IP              ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$IP${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}MASK            ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$MASK${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}GATEWAY         ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$GATEWAY${D}"
    if [ $SYSTEM == "Darwin" ] # MacOS
    then
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_TOTAL       ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_TOTAL GB${D}"
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_USED        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_USED MB${D}"
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_FREE        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_FREE MB${D}"
    else
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_TOTAL       ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_TOTAL GB${D}"
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_USED        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_USED GB${D}"
        echo -e "${LEFT_BACK}${LEFT_TEXT}RAM_FREE        ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$RAM_FREE GB${D}"
    fi
    echo -e "${LEFT_BACK}${LEFT_TEXT}SPACE_ROOT      ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$SPACE_ROOT MB${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}SPACE_ROOT_USED ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$SPACE_ROOT_USED MB${D}"
    echo -e "${LEFT_BACK}${LEFT_TEXT}SPACE_ROOT_FREE ${D}" = "${RIGHT_BACK}${RIGHT_TEXT}$SPACE_ROOT_FREE MB${D}"
}
