#!/bin/bash

if [[ $# -eq 1 ]]
then
    if [[ $1 =~ ^[0-9]+ ]]
    then
        echo "Invalid input"
    else
        echo $1
    fi
else
    echo "Enter one parameter"
fi
