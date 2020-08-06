FROM ubuntu:18.04 
MAINTAINER craftperson/kequandian.net

#RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \ 
    && apt-get -y install default-jre \
    && apt-get -y install nginx

## install nodejs_11
## 
#RUN apt-get -y install apt-utils curl gnupg
#RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
#RUN apt-get -y install nodejs
## end nodejs installation

## install redis
# RUN apt-get -y install redis-server

RUN apt-get install -y curl vim wget net-tools \
    && rm -rf /var/lib/apt/lists/*

## app config
RUN mkdir /webapps
WORKDIR   /webapps

ADD ./swagger /swagger
RUN ln -s /swagger /var/www/html/swagger


COPY ./config/logback-spring.xml /tmp
COPY ./config/produce.yml /tmp
COPY ./config/greenfield.yml /tmp
COPY ./script/run.sh /usr/local/bin
COPY ./script/fix_url.sh /usr/local/bin
COPY ./script/fix_endpoint.sh /usr/local/bin
COPY ./script/deploy-lib.sh /usr/local/bin
#COPY ./script/service.sh /usr/local/bin

## start mysqld service, run app and start up nginx in run.sh 
CMD sh /usr/local/bin/run.sh

