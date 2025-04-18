FROM eclipse-temurin:22-jre-alpine
WORKDIR /app
COPY build/libs/pharmacy-all.jar app.jar
RUN apk add --no-cache curl
ENV TZ=America/New_York
ENV JAVA_OPTS="-Xmx256m -Xms128m"
ENTRYPOINT ["java", "-jar", "app.jar"]