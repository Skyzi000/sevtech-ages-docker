FROM adoptopenjdk/openjdk8:x86_64-alpine-jre8u302-b08
MAINTAINER Jacob Wiltse <kelwing@kelnet.org>

ARG FILE_NUMBER=3125/814
ARG SEVTECH_VERSION=3.2.1

RUN mkdir -p /opt/ftb/world
WORKDIR /opt/ftb

RUN apk update &&\
    apk add --no-cache curl unzip

RUN curl -L -o server.zip https://media.forgecdn.net/files/${FILE_NUMBER}/SevTech_Ages_Server_${SEVTECH_VERSION}.zip &&\
    unzip server.zip &&\
    rm -f server.zip

COPY ops.json server.properties ./
# RUN sed -i 's/2048M/4096M/g' settings.sh
RUN chmod +x Install.sh ServerStart.sh
RUN ./Install.sh

ENTRYPOINT [ "/opt/ftb/ServerStart.sh" ]
