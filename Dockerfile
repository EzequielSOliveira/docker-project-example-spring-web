FROM maven:3.8.6-openjdk-18
WORKDIR .
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src src
RUN mvn clean install -Dmaven.test.skip=true
