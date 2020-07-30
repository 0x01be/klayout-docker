FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    git \
    build-base \
    py3-setuptools \
    curl-dev \
    expat-dev \
    python3-dev

RUN git clone --depth 1 https://github.com/KLayout/klayout.git /klayout

WORKDIR klayout

RUN python3 setup.py install

