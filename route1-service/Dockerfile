FROM maven:3.8.3-openjdk-17

EXPOSE 8083/tcp

WORKDIR /app

ADD target/route1-service-1.0.0.jar /app

ENTRYPOINT ["java","-jar","route1-service-1.0.0.jar"]