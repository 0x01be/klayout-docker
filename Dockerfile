FROM 0x01be/klayout:build as build

FROM 0x01be/xpra

COPY --from=build /opt/klayout/ /opt/klayout/

USER root
RUN apk add --no-cache --virtual klayout-runtime-dependencies \
    python3 \
    expat \
    curl \
    qt5-qtbase \
    qt5-qtxmlpatterns \
    qt5-qtsvg \
    qt5-qttools \
    ruby-libs \
    mesa-dri-swrast

COPY --from=build /klayout/samples/* /workspace/
RUN chown -R xpra:xpra /workspace

USER xpra

ENV PATH ${PATH}:/opt/klayout/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/klayout/lib/python3.8/site-packages/

ENV COMMAND klayout

WORKDIR /workspace

