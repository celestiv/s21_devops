#!/bin/bash

cd || exit
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_10.2.3_amd64.deb
sudo dpkg -i grafana_10.2.3_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable grafana-server

sudo systemctl start grafana-server
