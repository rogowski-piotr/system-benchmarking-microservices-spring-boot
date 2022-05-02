FROM maven:3.8.3-openjdk-17

EXPOSE 8082/tcp

WORKDIR /app

ADD target/distance-service-1.0.0.jar /app

ENTRYPOINT ["java","-jar","distance-service-1.0.0.jar"]