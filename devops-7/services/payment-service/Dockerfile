FROM eclipse-temurin:8-jdk-jammy AS build

WORKDIR /project/src
COPY . .
RUN ./mvnw -B dependency:go-offline && \
    ./mvnw -B package -DskipTests

FROM eclipse-temurin:8-jre-jammy

ARG JAR_FILE=/project/src/target/*.jar
COPY --from=build $JAR_FILE /project/payment.jar
WORKDIR /project/
EXPOSE 8084

COPY ./wait-for-it.sh .
RUN apt update && apt install bash && chmod +x /project/wait-for-it.sh
ENTRYPOINT ["bash", "-c", "\
./wait-for-it.sh -s -t 60 rabbitmq:5672 -- \
./wait-for-it.sh -s -t 60 postgres:5432 -- \
sleep 5 && java -jar *.jar"]
