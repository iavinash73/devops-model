# Use the official Maven image to build the application
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the source code into the container
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar my-app.jar

# Expose the application port (if applicable)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "my-app.jar"]
