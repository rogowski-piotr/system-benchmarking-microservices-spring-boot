FROM maven:3.8.3-openjdk-17

WORKDIR /app

COPY . /app

RUN mvn clean install spring-boot:repackage -Dmaven.test.skip

ENTRYPOINT ["java","-jar","target/gateway-0.0.1-SNAPSHOT.jar"]