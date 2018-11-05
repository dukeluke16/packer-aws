#!/bin/bash
# shellcheck disable=2048,2086
set -euo pipefail

WORKSPACE="${WORKSPACE:=$(pwd)}"

REGISTRY="dukeluke16"
IMAGE_NAME="packer-aws"
TAG=""
if [ $# -eq 0 ]; then
  TAG=latest
else
  TAG="$1"
  shift
fi

DOCKER_IMAGE=${REGISTRY}/${IMAGE_NAME}:${TAG}

docker pull $DOCKER_IMAGE

docker run -it --rm \
  -v $WORKSPACE:/root/src \
  --workdir /root/src \
  $DOCKER_IMAGE $*
