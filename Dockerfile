FROM alpine:edge
LABEL maintainer="Bojan Cekrlic - https://github.com/bokysan/docker-alpine-bootstrap/"


# Install basic set of tools
RUN   \
      apk add --no-cache --upgrade && \
      apk add --no-cache --update bash curl wget unzip tar xz sed gawk vim postgresql-client libressl python py-pip && \
      curl --retry 5 --max-time 300 --connect-timeout 10 -fsSL \
            https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
            -o /usr/local/bin/kubectl && \
      pip install awscli --upgrade && \
      apk -v --purge del py-pip && \
      (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

# Install wait-for-service
COPY  files/* /usr/local/bin/

