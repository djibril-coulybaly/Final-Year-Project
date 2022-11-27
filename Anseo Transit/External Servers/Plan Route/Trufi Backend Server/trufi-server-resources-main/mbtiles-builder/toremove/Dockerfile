FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y osmium-tool wget unzip

WORKDIR /app
RUN wget https://osmdata.openstreetmap.de/download/water-polygons-split-4326.zip
RUN unzip water-polygons-split-4326.zip
RUN mv water-polygons-split-4326 coastline

RUN wget https://github.com/systemed/tilemaker/releases/download/v2.0.0/tilemaker-ubuntu-16.04.zip
RUN unzip tilemaker-ubuntu-16.04.zip -d tilemaker
RUN chmod +x ./tilemaker/build/tilemaker

COPY ./run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT [ "sh", "./run.sh" ]
