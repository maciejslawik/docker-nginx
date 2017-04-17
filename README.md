# Nginx #

The repository stores Nginx web server container.

It has a simple vhost configured. By default it points to /var/www/app directory with hostname "docker".
It works with PHP-FPM linked as PHP:9000.

Map:
* your app root to /var/www/app
* log directory to /var/log/nginx (if you need easily-accessible server logs)
* your vhost directory to /etc/nginx/sites-available (if you need to modify the vhost config)