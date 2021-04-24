FROM adoptopenjdk:11-jre-hotspot
WORKDIR /webapps
RUN curl -sL https://github.com/kequandian/zero-io/releases/download/1.1.0/zero-io-all-1.1.0-standalone.jar -o /webapps/app.jar
CMD ["java", "-jar", "/webapps/app.jar", "--spring.profiles.active=produce", "--server.port=8080"]
