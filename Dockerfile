FROM alpine as build

RUN apk add --no-cache --virtual klayout-build-dependencies \
    git \
    build-base \
    py3-setuptools \
    curl-dev \
    expat-dev \
    python3-dev

RUN git clone --depth 1 https://github.com/KLayout/klayout.git /klayout

WORKDIR klayout

RUN python3 setup.py install --prefix=/opt/klayout

FROM alpine

RUN apk add --no-cache --virtual klayout-runtime-dependencies \
    python3 \
    expat \
    curl

ENV PATH ${PATH}:/opt/klayout/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/klayout/lib/python3.8/site-packages/

