FROM ubuntu:18.04

MAINTAINER Maciej Slawik <maciekslawik@gmail.com>

# Install nginx
RUN apt-get update && apt-get install -y \
    nginx

# Copy presets
ADD nginx.conf /etc/nginx/
ADD vhost.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/vhost.conf /etc/nginx/sites-enabled/vhost \
    && rm /etc/nginx/sites-enabled/default \
    && echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf \
    && usermod -u 1000 www-data

RUN chgrp -R www-data /var/www
RUN chmod -R g+rwx /var/www
RUN umask 0007

# Generate self-signed SSL certificate
RUN apt-get install -y openssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=PL/ST=malopolskie/L=Cracow/O=MSlwk/OU=MS/CN=ssl.website.com"

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
