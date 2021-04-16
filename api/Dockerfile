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

#ADD ./am .
ADD ./am/am-pack ./am/am-pack
ADD ./am/am-report ./am/am-report
ADD ./am/am-ticket ./am/am-ticket
ADD ./am/am-fault ./am/am-fault
ADD ./am/am-equipment ./am/am-equipment
ADD ./am/am-warehouse ./am/am-warehouse
ADD ./am/sb-document ./am/sb-document
ADD ./am/sb-category ./am/sb-category
ADD ./am/sb-workflow ./am/sb-workflow
ADD ./am/dashboard ./am/dashboard
ADD ./am/sb-organization ./am/sb-organization
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn install

WORKDIR /usr/src/am/am-pack
RUN --mount=type=cache,id=m2_cache,target=/root/.m2,rw mvn -DskipStandalone=false package -Dmaven.test.skip=true


FROM adoptopenjdk:11-jre-hotspot
WORKDIR /webapps
COPY --from=build /usr/src/am-pack/target/*-standalone.jar /webapps/app.jar

COPY ./ceiec-ems-docker-deploy/api/config/application.yml /webapps/config/application.yml
COPY ./ceiec-ems-docker-deploy/api/config/application-greenfield.yml /webapps/config/application-greenfield.yml
CMD ["java", "-jar", "/webapps/app.jar", "--spring.profiles.active=greenfield", "--server.port=8080"]
