FROM nginx:latest

WORKDIR /home/

COPY server/server.c /home
COPY server/run.sh /home
COPY server/nginx.conf /etc/nginx/nginx.conf

RUN apt update && \
    apt -y upgrade && \
    apt -y install libfcgi-dev spawn-fcgi gcc && \
    rm -rf /var/lib/apt/lists

RUN chmod +x /home/run.sh && \
    chown -R nginx:nginx /etc/nginx/nginx.conf && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /home && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chmod g-s /usr/bin/expiry && \
    chmod u-s /usr/bin/newgrp && \
    chmod g-s /usr/bin/chage && \
    chmod g-s /sbin/unix_chkpwd && \
    chmod u-s /bin/mount && \
    chmod g-s /usr/bin/wall && \
    chmod u-s /bin/su && \
    chmod u-s /usr/bin/passwd && \
    chmod u-s /usr/bin/chfn && \
    chmod u-s /usr/bin/chsh && \
    chmod u-s /usr/bin/gpasswd && \
    chmod u-s /bin/umount

USER nginx

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:80/ || exit 1

ENTRYPOINT [ "bash", "run.sh" ]
