FROM openjdk:11
WORKDIR /app
COPY ./target/*.jar /app/app.jar
EXPOSE 8005
CMD ["java","-jar","/app.jar"]
