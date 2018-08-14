FROM alpine:3.8

ENV CONSUL_TEMPLATE_VERSION="0.19.5" \
    DOCKER_HOST=unix:///tmp/docker.sock \
    DOCKER_VER=18.06.0-ce

RUN apk --no-cache add curl zip \
    && apk --no-cache upgrade \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip > ./consul.zip \
    && unzip consul.zip \
    && mv consul-template /usr/local/bin/consul-template \
    && rm consul.zip \
    && mkdir -p /consul-template /consul-template/config.d /consul-template/templates \
    && curl -fsSLO https://download.docker.com/linux/static/edge/x86_64/docker-${DOCKER_VER}.tgz \
    && tar --strip-components=1 -xvzf docker-${DOCKER_VER}.tgz docker/docker -C /bin \
    && apk del zip \
    && rm docker-${DOCKER_VER}.tgz

ENTRYPOINT [ "/usr/local/bin/consul-template" ]
