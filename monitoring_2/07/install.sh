#!/bin/bash

bash install_prometheus.sh
bash install_grafana.sh
bash install_node_exporter.sh

# # меняем конфигурацию prometheus, чтобы он читал метрики от node exporter
# sudo nano /etc/prometheus/prometheus.yml

sudo apt install -y nginx
sudo apt install -y stress