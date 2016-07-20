FROM alpine:3.4

ENV CONSUL_TEMPLATE_VERSION="0.15.0" \
    DOCKER_HOST=unix:///tmp/docker.sock

RUN apk --no-cache add curl bash zip \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip > ./consul.zip \
    && unzip consul.zip \
    && mv consul-template /usr/local/bin/consul-template \
    && rm consul.zip \
    && mkdir -p /consul-template /consul-template/config.d /consul-template/templates \
    && curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-latest > /bin/docker \
    && chmod +x /bin/docker \
    && apk del zip

ENTRYPOINT [ "/usr/local/bin/consul-template" ]
