FROM alpine as build

RUN apk add --no-cache --virtual klayout-build-dependencies \
    git \
    build-base \
    bash \
    python3-dev \
    py3-setuptools \
    ruby-dev \
    curl-dev \
    expat-dev \
    qt5-qtbase-dev \
    qt5-qtmultimedia-dev \
    qt5-qtxmlpatterns-dev \
    qt5-qtsvg-dev \
    qt5-qttools-dev \
    libexecinfo-dev

RUN git clone --depth 1 https://github.com/KLayout/klayout.git /klayout

WORKDIR /klayout

RUN mkdir -p /opt/klayout/bin
RUN python3 setup.py install --prefix=/opt/klayout

ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/klayout/lib/python3.8/site-packages/

RUN ./build.sh -release -ruby /usr/bin/ruby -python /usr/bin/python3 -qt5 -qmake /usr/bin/qmake-qt5 -build /klayout/build -bin /opt/klayout/bin -with-qtbinding -with-64bit-coord

ENV PATH ${PATH}:/opt/klayout/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/klayout/lib/python3.8/site-packages/

