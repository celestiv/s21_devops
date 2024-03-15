FROM postgres:16.2-alpine

WORKDIR /project
COPY init.sql /docker-entrypoint-initdb.d
USER postgres

# ENTRYPOINT [ "pg_ctl", "start" ]