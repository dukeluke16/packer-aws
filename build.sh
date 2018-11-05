#!/bin/bash
# shellcheck disable=2048,2086
set -euo pipefail

REGISTRY="dukeluke16"
IMAGE_NAME="packer-aws"
TAG=""
if [ $# -eq 0 ]; then
  echo "HELP - SYNTAX:  ${0} \${tag}"
  exit 1
else
  TAG="$1"
  shift
fi

docker build --squash -t ${REGISTRY}/${IMAGE_NAME}:${TAG} -t ${REGISTRY}/${IMAGE_NAME}:latest .
docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}
docker push ${REGISTRY}/${IMAGE_NAME}:latest
