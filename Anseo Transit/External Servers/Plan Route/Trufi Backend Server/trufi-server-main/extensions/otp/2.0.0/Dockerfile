FROM openjdk:11-jre

WORKDIR /app

ADD ./app/ .

RUN chmod +x ./run.sh

EXPOSE 8080 8081

ENTRYPOINT [ "sh", "./run.sh" ]
