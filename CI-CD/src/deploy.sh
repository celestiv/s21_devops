#!/bin/bash

USER=root
DIR=/usr/local/bin
ADDRESS=172.24.116.9

scp ./src/cat/s21_cat $USER@$ADDRESS:$DIR
scp ./src/grep/s21_grep $USER@$ADDRESS:$DIR