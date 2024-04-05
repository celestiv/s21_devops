#!/bin/bash

sudo apt update
sudo apt install -y docker.io
# https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker "$USER"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

JOIN_TOKEN=$(cat /vagrant/manager_token.txt)
docker swarm join --token "$JOIN_TOKEN" 192.168.50.10:2377

curl -L https://downloads.portainer.io/ee2-19/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy -c portainer-agent-stack.yml portainer
