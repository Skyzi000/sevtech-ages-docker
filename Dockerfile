FROM adoptopenjdk/openjdk8:x86_64-alpine-jre8u302-b08
MAINTAINER Jacob Wiltse <kelwing@kelnet.org>

ARG FILE_NUMBER=3125814

RUN mkdir -p /opt/ftb/world
WORKDIR /opt/ftb

RUN apk update &&\
    apk add --no-cache curl unzip

RUN curl -L -o server.zip https://www.curseforge.com/minecraft/modpacks/sevtech-ages/download/${FILE_NUMBER}/file &&\
    unzip server.zip &&\
    rm -f server.zip

COPY ops.json server.properties ./
# RUN sed -i 's/2048M/4096M/g' settings.sh
RUN Install.sh

ENTRYPOINT [ "ServerStart.sh" ]
