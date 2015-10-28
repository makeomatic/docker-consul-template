FROM gliderlabs/alpine
MAINTAINER Vitaly Aminev <v@makeomatic.ru>

ENV CONSUL_TEMPLATE_VERSION="0.11.1"

ADD https://github.com/hashicorp/consul-template/releases/download/v${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz /

RUN tar zxvf consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz && \
    mv consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64/consul-template /usr/local/bin/consul-template &&\
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tar.gz && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64 && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /bin/docker
RUN chmod +x /bin/docker

RUN apk --update add curl bash

ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT [ "/bin/consul-template" ]
