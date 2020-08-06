FROM ubuntu:16.04 
MAINTAINER craftperson/kequandian.net

RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \ 
    && apt-get -y install openjdk-8-jdk \
    && apt-get -y install nginx
RUN apt-get install -y curl vim wget net-tools \
    && rm -rf /var/lib/apt/lists/*

## app config
RUN mkdir /webapps 
WORKDIR   /webapps

COPY ./config/logback-spring.xml /tmp
COPY ./config/produce.yml /tmp
COPY ./config/greenfield.yml /tmp
COPY ./script/run.sh /usr/local/bin
COPY ./script/service.sh /usr/local/bin

## start mysqld service, run app and start up nginx in run.sh 
CMD sh /usr/local/bin/run.sh

