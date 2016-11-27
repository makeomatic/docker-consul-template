FROM alpine:3.4

ENV CONSUL_TEMPLATE_VERSION="0.16.0" \
    DOCKER_HOST=unix:///tmp/docker.sock \
    DOCKER_VER=1.12.3

RUN apk --no-cache add curl zip tar \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip > ./consul.zip \
    && unzip consul.zip \
    && mv consul-template /usr/local/bin/consul-template \
    && rm consul.zip \
    && mkdir -p /consul-template /consul-template/config.d /consul-template/templates \
    && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VER}.tgz && tar --strip-components=1 -xvzf docker-${DOCKER_VER}.tgz docker/docker -C /bin \
    && apk del zip tar

ENTRYPOINT [ "/usr/local/bin/consul-template" ]
