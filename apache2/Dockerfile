#
# Dockerfile
#
#
# Build:
#   docker build --rm -t httpd .
#
#
# Author:  Arul Selvan
# Version: Apr 4, 2020

FROM httpd:2.4.53-alpine

# install some network basic tools for debugging
RUN apk update --no-cache && apk add --no-cache netcat-openbsd bind-tools

COPY httpd.conf /usr/local/apache2/conf
