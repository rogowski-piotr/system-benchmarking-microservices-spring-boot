FROM maven:3.8.3-openjdk-17

EXPOSE 8081/tcp

WORKDIR /app

COPY coordinates.json /app

ADD target/place-service-1.0.0.jar /app

ENTRYPOINT ["java","-jar","place-service-1.0.0.jar"]