#!/bin/bash
CURRENT=$(cd $(dirname $0) && pwd)

if [ -z ${DOCKER_URL} ]; then
  DOCKER_URL="tcp://172.17.42.1:4243"
fi

if [ -z ${DOCKER_HOST_NGINX_CONF} ]; then
  DOCKER_HOST_NGINX_CONF=$CURRENT"/_nginx/example_conf.docker.d"
fi

if [ -z ${DOCKER_CERT_PATH} ]; then
  DOCKER_CERT_PATH="/tmp/my-docker-platform_$(/dev/urandom | tr -dc '[:digit:]' | head -c 16)"
fi

if [ -z ${DNSMASQ_CONFIG_DIR} ]; then
  DNSMASQ_CONFIG_DIR=$CURRENT"/_dnsmasq/example_dnsmasq.d"
fi

if [ -z ${AIPO_BACKUP_DIR} ]; then
  AIPO_BACKUP_DIR="/var/tmp/aipo/backup"
fi

IMAGE_NAME="s6464/my-docker-platform_installer"

mkdir --verbose --parents $AIPO_BACKUP_DIR
chmod 777 $AIPO_BACKUP_DIR

docker build -t $IMAGE_NAME .
docker run -it --rm -e DOCKER_HOST=$DOCKER_URL -e DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY -e DOCKER_HOST_CERT_PATH=$DOCKER_CERT_PATH -e DOCKER_HOST_NGINX_CONF="$DOCKER_HOST_NGINX_CONF" -e DNSMASQ_CONFIG_DIR="$DNSMASQ_CONFIG_DIR" -e AIPO_BACKUP_DIR="$AIPO_BACKUP_DIR" -v $DOCKER_CERT_PATH:/opt/from_dockerfile/certs $IMAGE_NAME
