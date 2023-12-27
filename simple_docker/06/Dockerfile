FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

RUN apt update && \
    apt -y upgrade && \
    rm -rf /var/lib/apt/lists


RUN chown -R nginx:nginx /etc/nginx/nginx.conf && \
    chown -R nginx:nginx /var/cache/nginx
