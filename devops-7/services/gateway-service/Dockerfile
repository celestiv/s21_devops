FROM eclipse-temurin:8-jdk-jammy AS build

WORKDIR /project/src
COPY . .
RUN ./mvnw -B dependency:go-offline && \
    ./mvnw -N io.takari:maven:wrapper && \
    ./mvnw -B package -DskipTests

FROM eclipse-temurin:8-jre-jammy

ARG JAR_FILE=/project/src/target/*.jar
WORKDIR /project/
COPY --from=build $JAR_FILE ./gateway.jar
EXPOSE 8087

ENTRYPOINT ["java", "-jar", "/project/gateway.jar"]
