#!/bin/bash

function echoing() {
    sys_info
    echo "HOSTNAME         = $HOSTNAME"
    echo "TIMEZONE         = $TIMEZONE"
    echo "USER             = $USER"
    echo "OS               = $OS"
    echo "DATE             = $DATE"
    echo "UPTIME           = $UPTIME"
    echo "UPTIME_SEC       = $UPTIME_SEC"
    echo "IP               = $IP"
    echo "MASK             = $MASK"
    echo "GATEWAY          = $GATEWAY"
    if [ $SYSTEM == "Darwin" ] # MacOS
    then
        echo "RAM_TOTAL        = $RAM_TOTAL GB"
        echo "RAM_USED         = $RAM_USED MB"
        echo "RAM_FREE         = $RAM_FREE MB"
    else
        echo "RAM_TOTAL        = $RAM_TOTAL GB"
        echo "RAM_USED         = $RAM_USED GB"
        echo "RAM_FREE         = $RAM_FREE GB"
    fi
    echo "SPACE_ROOT       = $SPACE_ROOT MB"
    echo "SPACE_ROOT_USED  = $SPACE_ROOT_USED MB"
    echo "SPACE_ROOT_FREE  = $SPACE_ROOT_FREE MB"
}
