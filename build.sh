#!/bin/sh
set -e

docker build -t dukeluke16/packer-aws .

docker tag dukeluke16/packer-aws:$1

docker tag dukeluke16/packer-aws:latest

docker push dukeluke16/packer-aws:$1

docker push dukeluke16/packer-aws:latest
