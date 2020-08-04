FROM 0x01be/alpine:edge as builder

RUN apk add --no-cache --virtual klayout-build-dependencies \
    git \
    build-base \
    py3-setuptools \
    curl-dev \
    expat-dev \
    python3-dev

RUN git clone --depth 1 https://github.com/KLayout/klayout.git /klayout

WORKDIR klayout

RUN python3 setup.py install

