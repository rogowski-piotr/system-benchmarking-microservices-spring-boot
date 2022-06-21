FROM maven:3.8.3-openjdk-17

EXPOSE 8084/tcp

WORKDIR /app

ADD target/route2-service-1.0.0.jar /app

ENTRYPOINT ["java","-jar","route2-service-1.0.0.jar"]