#
# Build stage
#
FROM eclipse-temurin:21-jdk-jammy AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
COPY ./java-resilience4j-lab $HOME
RUN ls -ltra

RUN apt-get update && apt-get install dos2unix
RUN dos2unix ./mvnw
RUN ./mvnw -f $HOME/pom.xml clean package

#
# Package stage
#
FROM eclipse-temurin:21-jre-jammy
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/app.jar
EXPOSE 8080

ENTRYPOINT ["java","-Xms128M","-Xmx128M","-jar","/app/app.jar"]
