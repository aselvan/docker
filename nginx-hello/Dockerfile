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

FROM nginx
LABEL net.selvans.image.author="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.maintainer="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.description="simple nginx image for testing purpose"
LABEL net.selvans.image.url="https://github.com/aselvan/docker"
LABEL net.selvans.image.version="1.0"

# We need to give all user groups write permission on folder /var/cache/nginx/ and 
# file /var/run/nginx.pid. So users with random uid will be able to run NGINX.
RUN chmod -R a+w /var/cache/nginx/ \
  && touch /var/run/nginx.pid \
  && chmod a+w /var/run/nginx.pid \
  && rm /etc/nginx/conf.d/*

COPY hello.conf /etc/nginx/conf.d/
EXPOSE 8080
USER nginx
