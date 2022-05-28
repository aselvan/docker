#
# Dockerfile.fpm
#
# Builds a php-fpm (alpine based) image for fastcgi service behind the nginx
#
# docker build -t fpm --rm -f fpm/Dockerfile .
#
# Author:  Arul Selvan
# Version: May 28, 2022
#

FROM php:7.4-fpm-alpine

MAINTAINER Arul Selvan <arul@selvansoft.com>

# TODO:
# add your PHP application and other directories here
#ADD ./bin /var/www/html/bin
#ADD ./config /var/www/html/config
#ADD ./migrations /var/www/html/migrations
#ADD ./public /var/www/html/public
#ADD ./src /var/www/html/src
#ADD ./templates /var/www/html/templates

# Add composer install tool, needed composer package and lock versions files etc.
ADD ./fpm/install_composer.php /var/www/html/install_composer.php
ADD ./fpm/composer.json /var/www/html/.
#ADD ./composer.lock /var/www/html/.

# your php.ini
ADD ./fpm/php.ini /usr/local/etc/php/.

RUN \
    # need mysql PDO
    docker-php-ext-install pdo pdo_mysql \
    # Installing composer
    && php /var/www/html/install_composer.php \
    # run composer to install "required" packages from the composer.json
    #&& composer install --no-scripts --optimize-autoloader --working-dir=/var/www/html \
    && composer install \
    && mkdir -p /home/www-data/.composer/cache \
    # set permission matching the user in /usr/local/etc/php-fpm.d/www.conf
    && chown -R www-data:www-data /home/www-data/ /var/www/html \
    # update timezone and install few packages we might need
    && apk add --update tzdata bash net-tools

WORKDIR /var/www/html

# overide any intermediate layer configured stopsignal
STOPSIGNAL SIGTERM

