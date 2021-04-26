#
# Dockerfile -- simple minimalistic container of kalilinux
#
# Author:  Arul Selvan
# Version: Apr 4, 2020
#

FROM kalilinux/kali-rolling

LABEL net.selvans.image.author="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.maintainer="Arul Selvan <github@selvans.net>"
LABEL net.selvans.image.description="kali linux image built with metasploit, responder, aircrack-ng etc on top of the base kalilinux/kali-rolling image"
LABEL net.selvans.image.url="https://github.com/aselvan/docker"
LABEL net.selvans.image.version="1.2"
LABEL net.selvans.image.kali.version="kalilinux/kali-rolling"
LABEL net.selvans.image.license="MIT License"


RUN apt-get -y update && apt-get -y install \
  metasploit-framework responder netcat aircrack-ng && \
  apt-get autoremove -y && \
  apt-get clean

CMD "/bin/bash"
