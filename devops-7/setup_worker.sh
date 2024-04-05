#!/bin/bash

sudo apt update
sudo apt install -y docker.io
# https://docs.docker.com/engine/install/linux-postinstall/
# sudo usermod -aG docker "$USER"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

JOIN_TOKEN=$(cat /vagrant/token.txt)
docker swarm join --token "$JOIN_TOKEN" 192.168.50.10:2377
