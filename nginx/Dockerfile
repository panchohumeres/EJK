FROM nginx:1.15-alpine

RUN apk add curl

RUN apk add --update bash

SHELL ["/bin/bash", "-c"]

RUN apt-get install systemd

RUN apt-get install service