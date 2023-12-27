#!/bin/bash

docker build ./05 -t test:1.1 -f ./Dockerfile
docker run -d -p 80:81 --name test test:1.1

export DOCKER_CONTENT_TRUST=1
# installation: $ brew install goodwithtech/r/dockle
dockle --ignore CIS-DI-0010 -ak NGINX_GPGKEY test:1.1
