FROM nginx:1.15-alpine

RUN apk add curl

RUN apk add nano

RUN apk add openrc

RUN apk add --update bash

#SHELL ["/bin/bash", "-c"]

RUN envsubst '${LOCALHOST} ${DOMAIN_KIBANA} ${DOMAIN_ELASTIC} ${DOMAIN_JUPYTER} ${SERVER_NAME_KIBANA} ${SERVER_NAME_ELASTIC} ${SERVER_NAME_JUPYTER} ${KIBANA_PORT} ${ELASTIC_PORT} ${JUPYTER_PORT}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/nginx.conf

EXPOSE 80