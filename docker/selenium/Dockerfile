FROM node:10.16.0-stretch

MAINTAINER Clever-Age DevOps Team <system@clever-age.com>

RUN apt-get update && apt-get install -y \
    vim \
    curl \
    wget \
    git \
    unzip \
    mysql-client \
    pv \
    netcat \
    sudo

ARG dev_uid=1000
ARG dev_gid=1000
ENV USER_NAME=selenium USER_ID="${dev_uid}" USER_GID="${dev_gid}"

# Create dev user
RUN ( getent group ${USER_GID} > /dev/null || groupadd --gid ${USER_GID} ${USER_NAME} ) \
 && useradd \
    --uid ${USER_ID} \
    --gid ${USER_GID} \
    --non-unique \
    --create-home \
    --shell /bin/bash \
    ${USER_NAME}

RUN mkdir -p /selenium

WORKDIR /selenium
