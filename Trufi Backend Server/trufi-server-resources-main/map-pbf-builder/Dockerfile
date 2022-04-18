FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y osmium-tool wget unzip

WORKDIR /app
RUN wget https://osmdata.openstreetmap.de/download/water-polygons-split-4326.zip
RUN unzip water-polygons-split-4326.zip
RUN mv water-polygons-split-4326 coastline

COPY ./run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT [ "sh", "./run.sh" ]
