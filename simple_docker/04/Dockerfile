FROM nginx:latest

WORKDIR /home/

COPY ../server/server.c /home
COPY ../server/run.sh /home

RUN apt update && \
    apt -y upgrade && \
    apt -y install libfcgi-dev spawn-fcgi gcc

ENTRYPOINT [ "bash", "run.sh" ]
