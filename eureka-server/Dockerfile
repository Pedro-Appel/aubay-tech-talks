#Build
# Use OpenJDK 21 as the base image
FROM maven:3.9.5-eclipse-temurin-21 AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 mvn clean package


#Package
FROM eclipse-temurin:21-jre-jammy
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/app.jar
EXPOSE 8761

ENTRYPOINT ["java","-jar","-Xms128M","-Xmx128M","/app/app.jar"]