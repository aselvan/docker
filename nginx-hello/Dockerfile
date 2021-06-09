#
# Dockerfile
#
# Simple nginx imgage for testing purpose 
#
# Source/Reference: https://github.com/nginxinc/NGINX-Demos
#
# Build:
#   docker build --rm -t docker.pkg.github.com/aselvan/docker/nginx-hello .
#
# Push:
#   cat ~/.git_docker_token |docker login docker.pkg.github.com -u aselvan --password-stdin
#   docker push docker.pkg.github.com/aselvan/docker/nginx-hello
#
#
# Author:  Arul Selvan
# Version: Jun 5, 2021
#

FROM nginx:alpine
LABEL net.selvans.image.author="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.maintainer="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.description="simple nginx image for testing purpose"
LABEL net.selvans.image.url="https://github.com/aselvan/docker"
LABEL net.selvans.image.version="1.0"

# install some network basic tools for debugging
RUN apk update --no-cache && apk add --no-cache netcat-openbsd bind-tools

COPY hello.conf /etc/nginx/conf.d/

