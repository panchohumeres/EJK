#!/usr/bin/env sh
set -eu

#echo "${KIBANA_GUEST_AUTH}"
envsubst '${KIBANA_GUEST_AUTH}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/nginx.conf
#echo "$@"

exec "$@"