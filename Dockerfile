FROM jre8:latest

WORKDIR /app

# 拷贝 jar（名字用通配，避免每次改）
COPY target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-version"]

ENTRYPOINT ["java","-jar","/app/app.jar"]
