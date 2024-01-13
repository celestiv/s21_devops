#!/bin/bash

export REGEX="^[a-zA-Z]{1,4}$"
export PART_1_EXT=("KB" "Kb" "kb")
export PART_2_EXT=("MB" "Mb" "mb")

export FONT_GREEN="\033[32m"
export FONT_RED="\033[31m"
export DEF="\033[0m"

CUR_DATE=$(date +"%d%m%y")
CUR_DATETIME=$(date +"%Y-%m-%d %T")
export CUR_DATE
export CUR_DATETIME

export MIN_NAME_LEN=4
export MAX_NAME_LEN=7
export MIN_EXT_LEN=1
export MAX_EXT_LEN=3
export SIZE_LIMIT=1048576
export LOG_DIR="/log/"
export SOURCE_DIR="/"

# part 4
export RESPONSE_CODES=(200 201 400 403 404 500 501 502 503)
export METHODS=("GET" "POST" "PUT" "PATCH" "DELETE")
export AGENTS=(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edge/16.16299"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Firefox/59.0"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Version/11.0.2 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Version/11.0.2 Chrome/58.0.3029.110 Safari/537.36"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Version/11.0.2 Edge/16.16299"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Version/11.0.2 Firefox/59.0"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Version/11.0.2 Chrome/58.0.3029.110 Safari/537.36"
)
export HTTP_TYPES=("HTTP/1.0" "HTTP/1.1" "HTTP/2.0")
export WEBSITES=("https://www.google.com" "https://www.amazon.com" "https://www.apple.com" "https://www.microsoft.com")

# part 9
FILE_PATH="/var/www/html/index.html"
export FILE_PATH
