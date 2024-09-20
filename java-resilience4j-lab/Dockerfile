FROM eclipse-temurin:21-jdk-jammy AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
COPY target/*.jar $HOME/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Xms128M","-Xmx128M","-jar","/app/app.jar"]
