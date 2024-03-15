FROM eclipse-temurin:8-jdk-jammy AS build

WORKDIR /project/src
COPY . .
RUN ./mvnw -B dependency:go-offline && \
    ./mvnw -N io.takari:maven:wrapper && \
    ./mvnw -B package -DskipTests

FROM eclipse-temurin:8-jre-jammy

ARG JAR_FILE=/project/src/target/*.jar
COPY --from=build $JAR_FILE /project/loyalty.jar
EXPOSE 8085

ENTRYPOINT java -jar /project/loyalty.jar
