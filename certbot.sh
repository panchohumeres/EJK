#!/bin/bash
# INIT-LETSENSCRYPT SCRIPT WITH PARAMETERS (FOR MULTIHOST CONFIG)
# script para generar certificados letsencrypt (certbot)--->https://github.com/wmnnd/nginx-certbot
#

echo "setting environment variables"
set -a
. ./.env
set +a

echo "                                    "

var=${1:-nada} #DEFAULT ARGUMENT "NADA"-->NOTHING

#THIS LOOPS THROUGH CLI ARGUMENTS IN CASE THEY EXIST
#DOMAIN NAMES ARE EXTRACTED FROM THERE AND DEFAULT IS NOT USED (ALL DOMAIN NAMES IN .ENV FILE)
if [ "$var" == "nada" ]; then #if no CLI arguments (i.e. domains) ALL DOMAINS IN .ENV FILE are passed
    echo "no CLI arguments provided, setting all domain variables (Elastic-Jupyter-Kibana) from .env file"
    domains=(${DOMAIN_KIBANA} ${DOMAIN_JUPYTER} ${DOMAIN_ELASTIC})

else
    domains=() #create array of domains
    for a in "$@" #loop through the array of domains
    do
        a=${a#*-} #remove "-" prefix from CLI argument
        domains+=( ${a} ) #add term without the prefix to domains array
    done

    for i in "${!domains[@]}"; do #loop through the array of domains (by index)
       domains[$i]="DOMAIN_${domains[$i]^^}" #uppercase domain element and concatenate to "DOMAIN" literal
    done

    for i in "${!domains[@]}"; do #loop again through the array of domains (by index)
        domains[$i]="${!domains[$i]}" #expand to variable name so as to get the value of the domain name
    done

data_path=${CERTBOT_PATH}
email=${email}

export IFS=";"




if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi


rsa_key_size=4096
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits

if [ -d "$data_path" ]; then
  read -p "Existing data found for $domains. Continue and replace existing certificate? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi


if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p "$data_path/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
  echo
fi

for d in "${domains[@]}"
do
  echo "### Creating dummy certificate for $d ..."
  path="/etc/letsencrypt/live/$d"
  mkdir -p "$data_path/conf/live/$d"



docker-compose run --rm --entrypoint "\
  openssl req -x509 -nodes -newkey rsa:1024 -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
echo

done


echo "### Starting nginx ..."
docker-compose up --force-recreate -d nginx
echo

for d in "${domains[@]}"
do
echo "### Deleting dummy certificate for $d ..."
  docker-compose run --rm --entrypoint "\
    rm -Rf /etc/letsencrypt/live/$d && \
    rm -Rf /etc/letsencrypt/archive/$d && \
    rm -Rf /etc/letsencrypt/renewal/$d.conf" certbot
  echo
done



# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

 #Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

for d in "${domains[@]}"
do
  echo "### Requesting Let's Encrypt certificate for $d ..."
  #Join $domains to -d args
  domain_args=""
  domain_args="$domain_args -d $d"

  docker-compose run --rm --entrypoint "\
    certbot certonly --webroot -w /var/www/certbot \
      $staging_arg \
      $email_arg \
      $domain_args \
      --rsa-key-size $rsa_key_size \
      --agree-tos \
      --force-renewal" certbot
  echo
done

echo "### Reloading nginx ..."
docker-compose exec nginx nginx -s reload