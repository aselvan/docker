#!/bin/bash
#
# sample-stack.sh 
#
# This script will build or run sample-stack.
#
# NOTE: This is a modified version of my original docker swarm stack script. Modified 
# to use docker-compose instead of docker swarm for development purpose
#
# Author:  Arul Selvan
# Version: May 28, 2022
#

stackName="sample-stack"
networkName="sample-net"
# for macOS testing use /tmp since we can't write to /etc not easily 
envFile="/tmp/sample.env"
#envFile="/etc/default/sample.env"
secure_env_file="/etc/default/sample_secure.env"
scriptPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
composeFile="$scriptPath/sample-stack.yaml"

check_root() {
  if [ `id -u` -ne 0 ] ; then
    echo "[ERROR] you must be 'root' to run this script... exiting."
    exit
  fi
}

validate_env() {
  # ensure selected env is available.
  echo "[INFO] Checking environment '$SAMPLE_ENV' ..."  
  if [ ! -f $scriptPath/../environments/sample_$SAMPLE_ENV.env ] ; then
    echo "[ERROR] Environment '$SAMPLE_ENV' is invalid (or)"
    echo "  missing config files in $scriptPath/../environments/"
    echo "  Check environment or config files and try again."
    exit
  fi
}

check_setup() {
  # see if setup is already done
  if [ ! -f $envFile ] ; then
    echo -e "[ERROR] setup is not done, please run $0 setup <prod|qa|dev> ..."
    exit
  fi
  
  set -o allexport
  source $envFile

  # override with prod creds.
  if [ -f $secure_env_file ] ; then
    source $secure_env_file
  fi

  if [ -z $SAMPLE_ENV ] ; then
    echo  "[ERROR]: SAMPLE_ENV is not set. It must be set to one of the following environments."
    env_list=$(ls -1 $scriptPath/../environments |awk -F'_' '{print $2}'|sed -e s/\.env//g)
    echo "  Valid Environments: $env_list"
    exit
  fi

  # ensure selected SAMPLE_ENV is available.
  validate_env
}

setup() {
  echo "[INFO] Seting up stack '${stackName}' ..."
  SAMPLE_ENV=$1
  
  if [ -z $SAMPLE_ENV ] ; then
    echo  "[ERROR]: Setup needs environment argument. Please retry with environment argument"
    echo  "Example: $0 setup dev"
    exit
  fi

  # ensure selected env is available.
  validate_env

  # setup environment
  cp -f $scriptPath/../environments/sample_$SAMPLE_ENV.env $envFile
  if [ $? -ne 0 ] ; then
    echo  "[ERROR] unable to copy $scriptPath/../environments/sample_$SAMPLE_ENV.env to $envFile"
    exit
  fi
  # TODO: a temporary hack since docker-compose is stupid and expecting .env in current path !#@$
  # it doesn't hurt to leave this work around in place for docker swarm which doesn't use this anyway.
  cp -f $scriptPath/../environments/sample_$SAMPLE_ENV.env $scriptPath/.env
  
  # create private bridge network if not created.
  networkExists=$(docker network ls -q -f driver=bridge -f name=$networkName)
  if [ -z "$networkExists" ] ; then
    echo  "[INFO] network '$networkName' does not exists, creating..."
    docker network create -d bridge $networkName
  else 
    echo  "[INFO] network '$networkName' already exist, skipping network create."
  fi
 
  # check and see if this node is part of a swarm cluster.
  #docker swarm join-token manager
  #rc=$?
  #if [ $rc -ne 0 ] ; then
  #  echo "[ERROR] docker swarm is not setup, contact system admin to setup swarm cluster for this node"
  #  exit
  #fi
  echo  "[INFO] Setup complete."
}

check_network() {
  # wait for our private network to come down.
  count=0
  wait_count=60
  docker network prune -f >/dev/null 2>&1
  while [ ! -z "$(docker network ls -q -f driver=bridge -f name=$networkName)" ]; do
    echo -n -e "\r[INFO] waiting for network '$networkName' to tear down: $count";
    sleep 1
    let count=$count+1;
    if [ $count -gt $wait_count ]; then
      echo ""
      echo "[ERROR] Network is not coming down, service may not start"
      break
    fi
  done
  echo ""
}

start() {
  check_setup
  echo "[INFO] Starting stack ${stackName} [env: ${SAMPLE_ENV}] ..."
  #docker stack deploy --compose-file ${composeFile} ${stackName}_${SAMPLE_ENV}
  # using docker-compose for now
  (cd $scriptPath; docker-compose -f ${composeFile} up -d)
}

stop() {
  check_setup
  echo "[INFO] Stopping stack ${stackName} [env: ${SAMPLE_ENV}] ..."
  #docker stack rm ${stackName}_${SAMPLE_ENV}
  (cd $scriptPath; docker-compose -f ${composeFile} down)
  check_network  
}

status() {
  check_setup
  echo "[INFO] Status of stack ${stackName} [env: ${SAMPLE_ENV}] ..."  
  (cd $scriptPath; docker-compose -f ${composeFile} ps)
  #echo  "[INFO] Lists the tasks that are running as part of ${stackName}_${SAMPLE_ENV} stack"
  #docker stack ps ${stackName}_${SAMPLE_ENV}
  #echo  "[INFO] List the services in ${stackName}_${SAMPLE_ENV} stack"
  #docker stack services ${stackName}_${SAMPLE_ENV}
}

build() {
  # cd to the root dir first
  echo "[INFO] building docker images for Sample stack..."
  
  cd $scriptPath/.. || exit 1
  echo "############## Building FPM image ###############"
  docker build -t fpm  --rm -f fpm/Dockerfile .

  echo "############## Building nginx image ###############"
  docker build -t nginx  --rm -f nginx/Dockerfile .
}

# ---------- main ----------
#check_root

case $1 in
  setup|start|stop|status|build) "$@"
  ;;
  *) echo "Usage: $0 setup <prod|qa|dev>|start|stop|status|build>"
  ;;
esac

exit 0
