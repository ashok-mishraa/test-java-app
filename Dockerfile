# Build the application first using Maven
FROM maven:3.8-openjdk-11 as build
WORKDIR /app
COPY . .
RUN mvn clean package

# Inject the JAR file into a new container to keep the file small
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/camel-sports-api-*-SNAPSHOT.jar /app/carmel-sport-api.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar carmel-sport-api.jar"]
