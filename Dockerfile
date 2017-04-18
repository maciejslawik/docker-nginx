FROM debian:jessie

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

CMD ["nginx"]

EXPOSE 80
EXPOSE 443