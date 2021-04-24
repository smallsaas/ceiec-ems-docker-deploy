#build-stage
FROM zelejs/allin-web:alpine-m2 AS M2

#build-stage
FROM daocloud.io/library/maven:3.6.0-jdk-11-slim AS build

# init .m2 from alpine-m2 image first
WORKDIR /root/.m2
COPY --from=M2 /root/.m2 /root/m2
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw cp -r /root/m2/* /root/.m2

## mvn package
WORKDIR /usr/src

ADD ./am .
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn install
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn -DskipStandalone=false package -Dmaven.test.skip=true


FROM adoptopenjdk:11-jre-hotspot
WORKDIR /webapps
COPY --from=build /usr/src/am-pack/target/*-standalone.jar /webapps/app.jar

COPY ./ceiec-ems-docker-deploy/api/config/application.yml /webapps/config/application.yml
COPY ./ceiec-ems-docker-deploy/api/config/application-greenfield.yml /webapps/config/application-greenfield.yml
CMD ["java", "-jar", "/webapps/app.jar", "--spring.profiles.active=greenfield", "--server.port=8080"]
