#build-stage
FROM zelejs/allin-web:alpine-m2 AS M2

#get-src
FROM daocloud.io/library/node:12 as src
WORKDIR /usr/src
RUN git clone https://github.com/kequandian/zero-io --branch master --single-branch 

#build-stage
FROM daocloud.io/library/maven:3.6.0-jdk-11-slim AS build

# init .m2 from alpine-m2 image first
WORKDIR /root/.m2
COPY --from=M2 /root/.m2 /root/m2
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw cp -r /root/m2/* /root/.m2

## mvn package
WORKDIR /usr/src
COPY --from=src /usr/srczero-io ./zero-io

WORKDIR /usr/src/zero-io
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn install

WORKDIR /usr/src/zero-io/zero-io-all
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn -DskipStandalone=false package -Dmaven.test.skip=true

#final-stage
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /webapps
COPY --from=build /usr/src/zero-io/zero-io-all/target/*-standalone.jar /webapps/app.jar

CMD ["java", "-jar", "/webapps/app.jar", "--spring.profiles.active=greenfield", "--server.port=8080"]
