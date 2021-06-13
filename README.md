# docker images

### Misl. collection of docker images.

- #### /openjdk
  This contains multiple (compact & full) versions of openjdk16 (alpine3.13 based) and openjdk11 (buster slim based). 
  The complact versions are built with very selective java runtime components. The image is built at dockerhub
  at the location [https://hub.docker.com/repository/docker/aselvan/openjdk] and can be pulled 
  by `docker pull aselvan/openjdk:16` 

- #### /kali
  This is a kali linux image built with metasploit, responder, aircrack-ng etc on top of the base 
  kalilinux/kali-rolling image. The image is built at dockerhub [https://hub.docker.com/repository/docker/aselvan/kali] 
  and can be pulled by `docker pull aselvan/kali:latest`

- #### /nginx-hello
  This is a nginx test image for test/debug purpose.
  The image is built at dockerhub [https://hub.docker.com/repository/docker/aselvan/nginx-hello] 
  and can be pulled by `docker pull aselvan/nginx-hello`

- #### /haproxy
  This is a haproxy container [just change haproxy.cfg and create your SSL certs to use]
  The image is built at dockerhub [https://hub.docker.com/repository/docker/aselvan/haproxy]
  and can be pulled by `docker pull aselvan/haproxy`
