#FROM maven:latest AS build
#WORKDIR /app
#COPY pom.xml .
#COPY src ./src
#RUN mvn clean package -DskipTests
#
#FROM openjdk:latest
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#COPY config/.env .env
#
#EXPOSE 8080
#
#ENV  MSSQL_SA_PASSWORD="Admin@123"
#ENV  MSSQL_SA="sa"
#ENV  DB_URL="jdbc:sqlserver://localhost;databaseName=RestaurantDb;trustServerCertificate=true;multipleActiveResultSets=true"
#
#CMD ["java", "-jar", "app.jar"]

#docker build -t mi-spring-boot-app .
#docker run -p 8080:8080 mi-spring-boot-app


# Etapa de compilación
# Etapa de compilación
FROM maven:latest AS build
WORKDIR /app
COPY ../pom.xml .
COPY ../src ./src
RUN mvn clean package -DskipTests

# Verifica los archivos en el directorio de salida
RUN ls -la /app/target

# Etapa de ejecución
FROM openjdk:latest
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
#
#ENV MSSQL_SA_PASSWORD="Admin@123"
#ENV MSSQL_SA="sa"
#ENV DB_URL="jdbc:sqlserver://localhost;databaseName=RestaurantDb;trustServerCertificate=true;multipleActiveResultSets=true"

CMD ["java", "-jar", "app.jar"]

# cd ..
# docker build -t mi-spring-boot-app -f config/Dockerfile .