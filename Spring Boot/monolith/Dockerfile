FROM maven:3.8.3-openjdk-17

EXPOSE 8080/tcp

WORKDIR /app

COPY coordinates.json /app

ADD target/monolith-0.0.1.jar /app

ENTRYPOINT ["java","-jar","monolith-0.0.1.jar"]