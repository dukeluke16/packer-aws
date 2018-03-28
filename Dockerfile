#
# packer-aws Build Environment Dockerfile
#

# Pull base image.
FROM alpine:3.7
MAINTAINER Luke Thompson <luke@dukeluke.com>
LABEL Description="This image provides a dockerized build environment containing Python, Ansible, Packer, AWS-CLI, and Terraform."

# Set environment variables.
ENV HOME /root
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Define working directory.
WORKDIR /root

# Service Build Dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache alpine-sdk libffi-dev build-base musl-dev libsodium-dev jq wget unzip && \
    apk add --no-cache openssl-dev ca-certificates && \
    apk add --no-cache git zsh go && \
    apk add --no-cache python py-pip python-dev py-setuptools && \
    pip install --upgrade pip pipenv setuptools awscli && \
    update-ca-certificates && \
    rm -f /tmp/* /etc/apk/cache/* && \
    rm -r /root/.cache && \
    wget -O /tmp/terraform.zip -q https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm -f /tmp/terraform.zip && \
    chmod 755 /usr/local/bin/terraform

# configure go
ENV GOPATH $HOME/go
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# packer install
RUN go get -u github.com/hashicorp/packer
ENV PACKER_LOG=1
ENV CHECKPOINT_DISABLE=1

# pipenv install
COPY Pipfile /root/Pipfile
COPY Pipfile.lock /root/Pipfile.lock
RUN pipenv install
RUN rm /root/Pipfile
RUN rm /root/Pipfile.lock

# Configure zsh
ENV SHELL=/bin/zsh
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Set Entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
