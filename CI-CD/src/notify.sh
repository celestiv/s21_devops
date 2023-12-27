#!/bin/bash

if [[ $CI_JOB_STATUS == 'success' ]] ; then
    CI_JOB_STATUS="SUCCESS✅"
else
    CI_JOB_STATUS="FAILED⛔️"
fi

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Project: $CI_PROJECT_NAME%0A%0ACommit: $CI_COMMIT_MESSAGE%0A%0AJob name: $CI_JOB_NAME%0A%0AStatus: $CI_JOB_STATUS"

curl -s -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
