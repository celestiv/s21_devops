#!/bin/bash

docker build ./05 -t test:1.1
docker run -d -p 80:81 --name test test:1.1

echo "Список образов:"

docker images

echo "Попробуем обратиться к странице:"

curl localhost:80
