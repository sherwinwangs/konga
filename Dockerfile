FROM node:10.16-alpine

COPY . /app

WORKDIR /app

RUN apk upgrade --update \
    && apk add bash git ca-certificates \
    && npm install -g bower \
    && npm --unsafe-perm --production install \
    && apk del git \
    && mkdir /app/kongadata \
    && rm -rf /var/cache/apk/* \
        /app/.git \
        /app/screenshots \
        /app/test \
    && chown -R 1000.1000 /app

EXPOSE 1337

VOLUME /app/kongadata
USER 1000
ENTRYPOINT ["/app/start.sh"]
