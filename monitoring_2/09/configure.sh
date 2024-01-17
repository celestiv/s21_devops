#!/bin/bash

function configure() {

# Копируем файл в папку с конфигом:
sudo cp prometheus.yml /etc/prometheus/
sudo cp nginx.conf /etc/nginx/

sudo chown "$USER" /run/nginx.pid
sudo chown "$USER" /var/log/nginx/error.log
sudo chown "$USER" /var/log/nginx/access.log

sudo nginx -t
sudo nginx -s reload
}
