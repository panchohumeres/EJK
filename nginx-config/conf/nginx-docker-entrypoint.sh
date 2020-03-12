set -eu

apk add curl
#echo "${KIBANA_GUEST_AUTH}"
envsubst '${LOCALHOST} ${DOMAIN_KIBANA} ${DOMAIN_ELASTIC} ${DOMAIN_JUPYTER} ${SERVER_NAME_KIBANA} ${SERVER_NAME_ELASTIC} ${SERVER_NAME_JUPYTER} ${KIBANA_PORT} ${ELASTIC_PORT} ${JUPYTER_PORT}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/nginx.conf
#echo "$@"
while :; do sleep 6h && wait $${!}; nginx -s reload; done && nginx -g \"daemon off;\"