FROM openjdk:8u131-jdk-alpine

MAINTAINER Gopala Krishnan <gopac25@gmail.com

EXPOSE 8080

WORKDIR /usr/local/bin/

COPY target/dev-v1.0.jar webapp.jar

CMD ["java", "-Xmx50m","-jar","webapp.jar"]
