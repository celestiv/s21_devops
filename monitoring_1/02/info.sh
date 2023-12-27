#!/bin/bash

function sys_info() {
    SYSTEM=$(uname)
    if [ $SYSTEM == "Darwin" ] # MacOS
    then
        HOSTNAME=$(hostname)
        TIMEZONE=$(date +%Z%z)

        OS=$(sw_vers -productName)-$(sw_vers -productVersion)
        DATE=$(date +"%d %b %Y %H:%M:%S")

        UPTIME=$(uptime)
        UPTIME_DAYS=$(uptime | awk '{printf "%.0f\n", $3}')
        UPTIME_HOURS=$(uptime | awk '{printf "%.0f\n", $5}')
        UPTIME_MINS=$(uptime | awk '{print $5}' | awk -F ':' '{printf "%.0f\n", $2}')
        UPTIME_SEC=$((UPTIME_DAYS * 24 * 3600 + UPTIME_HOURS * 3600 + UPTIME_MINS * 60))
        
        MASK=$(ifconfig en0 | grep 'inet ' | awk '{print $4}')
        GATEWAY=$(netstat -nr | grep default | head -1 | awk '{print $2}')

        RAM_TOTAL=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2}')

        FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
        INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
        SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')

        FREE=$((($FREE_BLOCKS+SPECULATIVE_BLOCKS)*$(pagesize)/1024/1024))
        INACTIVE=$(($INACTIVE_BLOCKS*$(pagesize)/1024/1024))
        RAM_FREE=$(($FREE+$INACTIVE))
        RAM_USED=$((RAM_TOTAL*1024-RAM_FREE))
    else # linux
        HOSTNAME=$(hostname)
        TIMEZONE=$(timedatectl show --property=Timezone --value)
        OS=$(hostnamectl | grep "Operating System" | awk '{print $3, $4}')
        DATE=$(date +"%d %b %Y %H:%M:%S")
        UPTIME=$(uptime -p)
        UPTIME_SEC=$(cat /proc/uptime | awk '{printf "%.0f\n", $1}')

        MASK=$(ifconfig lo | grep 'inet ' | awk '{print $4}')
        GATEWAY=$(ip r | grep default | awk '{print $3}')

        RAM_TOTAL=$(free | grep Mem | awk '{printf "%0.3f\n", $2/1024/1024}')
        RAM_USED=$(free | grep Mem | awk '{printf "%0.3f\n", $3/1024/1024}')
        RAM_FREE=$(free | grep Mem | awk '{printf "%0.3f\n", $4/1024/1024}')
    fi

    USER=$(whoami)
    IP=$(ifconfig | grep -w inet | awk '{print $2}' | grep -v "127.0.0.1" | tail -1)

    SPACE_ROOT=$(df -m | grep "/$" | awk '{printf "%0.2f\n", $2}')
    SPACE_ROOT_USED=$(df -m | grep "/$" | awk '{printf "%0.2f\n", $3}')
    SPACE_ROOT_FREE=$(df -m | grep "/$" | awk '{printf "%0.2f\n", $4}')
}
