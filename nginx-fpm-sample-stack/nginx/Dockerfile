#
# Dockerfile
#
# Builds a nginx (alpine based) sample image 
#
#
# docker build -t nginx --rm -f nginx/Dockerfile .
#
# Author:  Arul Selvan
# Version: May 28, 2022
#

FROM nginx:1.21.6-alpine

MAINTAINER Arul Selvan <arul@selvansoft.com>

# ensure tzdata and few tools are installed.
RUN apk add --update tzdata bash net-tools

# add the code (uncoment to add your app)
#ADD ./public /var/www/html/public

# overwrite nginx, server configs.
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf

# replace with your nginx conf
#ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx/hello.conf /etc/nginx/conf.d/default.conf

# overide any intermediate layer configured stopsignal
STOPSIGNAL SIGWINCH

WORKDIR /var/www/html
