FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y pbzip2 wget

WORKDIR /app

COPY ./start.sh ./start.sh

ENTRYPOINT [ "sh", "./start.sh" ]