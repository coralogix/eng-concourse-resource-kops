FROM alpine:3.12

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="eng-concourse-resource-kops" \
      org.label-schema.description="A Concourse resource for validating Kops cluster." \
      org.label-schema.vcs-url="https://github.com/coralogix/eng-concourse-resource-kops" \
      org.label-schema.vendor="Coralogix, Inc." \
      org.label-schema.version="v1.18.1"

ENV KOPS_VERSION=v1.18.1

RUN set -euo pipefail; \
  apk --no-cache add \
    bash \
    curl \
    jq && \
  mkdir -p /tmp && \
  curl -L --output /usr/local/bin/kops \
    https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-linux-amd64 && \
  chmod +x /usr/local/bin/kops && \
  apk --no-cache del \
    curl

WORKDIR /opt/resource

COPY ./check ./in ./out /opt/resource/
