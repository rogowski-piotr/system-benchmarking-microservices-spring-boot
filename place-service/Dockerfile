FROM maven:3.8.3-openjdk-17

WORKDIR /app

COPY . /app

RUN mvn clean package -Dmaven.test.skip

ENTRYPOINT ["java","-jar","target/place-service-0.0.1-SNAPSHOT.jar"]