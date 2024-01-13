#!/bin/bash

source ../common/config.sh

function write_html() {
  CPU=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{print 100 - $8}')
  RAM=$(free | grep Mem | awk '{print $2}')
  RAM_USED=$(free | grep Mem | awk '{print $3}')
  DISK=$(df -k / | grep / | awk '{print $2}')
  DISK_USED=$(df -k / | grep / | awk '{print $3}')
  Total_IOs=$(vmstat 1 2 | tail -1 | awk '{print $10 + $11}')

  echo "# HELP cpu CPU stats"> "$FILE_PATH"
  echo "# TYPE cpu gauge">> "$FILE_PATH"
  echo "cpu $CPU">> "$FILE_PATH"
  echo "# HELP ram_all bytes of RAM">> "$FILE_PATH"
  echo "# TYPE ram_all gauge">> "$FILE_PATH"
  echo "ram_all $RAM">> "$FILE_PATH"
  echo "# HELP ram_used used bytes of RAM">> "$FILE_PATH"
  echo "# TYPE ram_used gauge">> "$FILE_PATH"
  echo "ram_used $RAM_USED">> "$FILE_PATH"
  echo "# HELP disk_space bytes of all disk space">> "$FILE_PATH"
  echo "# TYPE disk_space gauge">> "$FILE_PATH"
  echo "disk_space $DISK">> "$FILE_PATH"
  echo "# HELP disk_space_used bytes of all disk space">> "$FILE_PATH"
  echo "# TYPE disk_space_used gauge">> "$FILE_PATH"
  echo "disk_space_used $DISK_USED">> "$FILE_PATH"
  echo "Total_IOs: $Total_IOs" >> "$FILE_PATH"
}

function make_server() {
  cp prometheus.yml /usr/local/bin/
  cp nginx.conf /etc/nginx/
  nginx -s reload

  while true; do
    write_html
    sleep 5
  done;
}

make_server
