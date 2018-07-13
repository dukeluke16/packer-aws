#!/bin/sh
set -e

if [ -z $WORKSPACE ]
then
  WORKSPACE=$(pwd)
fi

DOCKER_IMAGE=dukeluke16/packer-aws:latest

docker pull $DOCKER_IMAGE

docker run -it --rm \
  -v $WORKSPACE:/root/src \
  --workdir /root/src \
  $DOCKER_IMAGE $*
