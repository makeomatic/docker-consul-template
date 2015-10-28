FROM gliderlabs/alpine
MAINTAINER Vitaly Aminev <v@makeomatic.ru>

ENV CONSUL_TEMPLATE_VERSION="0.11.1"

RUN apk --update add curl bash zip

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template &&\
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /bin/docker
RUN chmod +x /bin/docker
RUN apk del --purge zip

ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT [ "/usr/local/bin/consul-template" ]
