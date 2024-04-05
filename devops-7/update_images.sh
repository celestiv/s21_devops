#!/bin/bash

if [[ ! $# -eq 1 ]]; then
    echo "Usage: bash update_images.sh <version of the image>"
    echo "For example: bash update_images.sh 1.3"
    exit 1
fi

docker stop $(docker ps -q)
docker container rm -f $(docker ps -a -q)
docker image rm -f $(docker image ls -q)
docker volume rm -f $(docker volume ls -q)
docker network rm -f $(docker network ls -q)

VERSION=$1
SERVICES=("booking" "hotel" "payment" "session" "gateway" "report" "loyalty")


for service in "${SERVICES[@]}"; do
    docker build -t celestiv/${service}_service:${VERSION} ./services/${service}-service/
    docker push celestiv/${service}_service:${VERSION}
done
