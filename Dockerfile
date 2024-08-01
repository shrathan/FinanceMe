FROM openjdk:11
COPY ./target/*.jar /app/app.jar
EXPOSE 8005
ENTRYPOINT ["java","-jar","/app.jar"]
