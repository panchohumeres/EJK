FROM nginx:1.15-alpine

RUN apk add curl

RUN apk add --update bash

RUN ["/bin/bash", "-c", "apt-get install systemd"]

RUN ["/bin/bash", "-c", "apt-get install service"]