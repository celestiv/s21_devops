#!/bin/bash

USER=celestiv
DIR=/usr/local/bin/
ADDRESS=172.24.116.9
SRC_DIR=./src/

scp ${SRC_DIR}cat/s21_cat $USER@$ADDRESS:$DIR
scp ${SRC_DIR}grep/s21_grep $USER@$ADDRESS:$DIR