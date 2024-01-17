#!/bin/bash

source ../common/config.sh
source configure.sh

function write_html() {
  CPU=$(top -bn2 | grep "Cpu(s)" | tail -1 | awk '{print 100 - $8}')
  RAM=$(free | grep Mem | awk '{print $2}')
  RAM_USED=$(free | grep Mem | awk '{print $3}')
  DISK=$(df -k / | grep / | awk '{print $2}')
  DISK_USED=$(df -k / | grep / | awk '{print $3}')
  Total_IOs=$(vmstat 1 2 | tail -1 | awk '{print $10 + $11}')

  echo -e "# HELP my_cpu_load A help string\n"  > "$FILE_PATH"
  echo -e "# TYPE my_cpu_load gauge\n"  >> "$FILE_PATH"
  echo -e "my_cpu_load{type=\"user\",cpu=\"cpu0\"} $CPU"  >> "$FILE_PATH"
  echo -e "# HELP my_memory_used_mibibytes A help string"  >> "$FILE_PATH"
  echo -e "# TYPE my_memory_used_mibibytes gauge"  >> "$FILE_PATH"
  echo -e "my_memory_used_mibibytes $RAM_USED"  >> "$FILE_PATH"
  echo -e "# HELP my_memory_total_mibibytes A help string"  >> "$FILE_PATH"
  echo -e "# TYPE my_memory_total_mibibytes gauge"  >> "$FILE_PATH"
  echo -e "my_memory_total_mibibytes $RAM"  >> "$FILE_PATH"
  echo -e "# HELP my_filesystem_size_used_mibibytes A help string"  >> "$FILE_PATH"
  echo -e "# TYPE my_filesystem_size_used_mibibytes gauge"  >> "$FILE_PATH"
  echo -e "my_filesystem_size_used_mibibytes $DISK_USED"  >> "$FILE_PATH"
  echo -e "# HELP my_filesystem_size_free_mibibytes A help string"  >> "$FILE_PATH"
  echo -e "# TYPE my_filesystem_size_free_mibibytes gauge"  >> "$FILE_PATH"
  echo -e "my_filesystem_size_free_mibibytes $(("$DISK" - "$DISK_USED"))"  >> "$FILE_PATH"
  echo -e "# HELP my_total_disk_reads_writes A help string"  >> "$FILE_PATH"
  echo -e "# TYPE my_total_disk_reads_writes gauge" >> "$FILE_PATH"
  echo -e "my_total_disk_reads_writes $Total_IOs" >> "$FILE_PATH"
}

function make_server() {
  sudo mkdir -p /var/www/html/node/
  sudo chown "$USER" "/var/www/html/node/"
  while true; do
    write_html
    sleep 5
  done;
}

configure
make_server
