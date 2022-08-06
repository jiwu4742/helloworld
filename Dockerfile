FROM maven:3.8.6-eclipse-temurin-8-alpine AS builder
WORKDIR /app
COPY . .
RUN mvn --threads 1.5C clean package

FROM openjdk:19-jdk-alpine3.15
WORKDIR /app
COPY --from=builder /app/target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080/tcp
ENTRYPOINT ["java", "-jar", "app.jar"]