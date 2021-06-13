#
# Dockerfile
#
# This builds a haproxy image w/ sample configurations
#
# Build:
#   docker build --rm -t docker.pkg.github.com/aselvan/docker/haproxy:latest .
#
# Push:
#   cat ~/.git_docker_token |docker login docker.pkg.github.com -u aselvan --password-stdin
#   docker push docker.pkg.github.com/aselvan/docker/haproxy:latest
#
# Run:
#   docker run -p 443:443 --rm -it docker.pkg.github.com/aselvan/docker/haproxy:latest
#
# SSL Cert:
#   The 'sample' self-signed cert used is created as follows, replace it w/ yours ofcourse!
#
#   # create the cert and private key
#   openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -keyout sample.crt.key -out sample.crt
#   
#   # get csr (for signing later with a certified authority)
#   openssl req -new -key sample.crt.key -out server.csr
#
# Author:  Arul Selvan
# Version: Sep 5, 2019
#

# base haproxy image w/ alpine LTS
FROM  haproxy:lts-alpine 
LABEL net.selvans.image.author="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.maintainer="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.description="haproxy sample"
LABEL net.selvans.image.url="https://github.com/aselvan/docker"
LABEL net.selvans.image.version="1.1"
LABEL net.selvans.image.alpine.version="LTS"
LABEL net.selvans.image.license="MIT License"

# install basic tools we may need on the vanila image
USER root
RUN apk add --update --no-cache tzdata netcat-openbsd bind-tools

# install cert, config etc
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg 
COPY sample.crt  /etc/ssl/certs/server.crt
COPY sample.crt.key /etc/ssl/certs/server.crt.key
