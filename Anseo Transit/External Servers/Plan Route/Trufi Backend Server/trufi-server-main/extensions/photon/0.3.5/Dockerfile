FROM openjdk:8-alpine
ENV PHOTON_VERSION="0.3.5"
LABEL version="$PHOTON_VERSION"

EXPOSE 2322/tcp

RUN ["mkdir", "app"]

ADD ./photon-$PHOTON_VERSION.jar /app/photon.jar
WORKDIR /app

RUN ["mkdir", "photon_data"]

VOLUME /app/photon_data

ENTRYPOINT ["java", "-jar", "photon.jar"]
