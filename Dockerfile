FROM adoptopenjdk/openjdk11:alpine
WORKDIR /app
COPY target/*.jar ./app/jar
CMD ["java", "-jar", "app.jar"]