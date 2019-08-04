# docker-elastic-kibana-jupyter

#iniciar con este comando
sudo sysctl -w vm.max_map_count=262144

#matar todos los contenedores
docker kill $(docker ps -q)
docker-compose stop

#Probar conexión SSL/TSL a elasticsearch https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls-docker.html
docker run --rm -v es_certs:/certs --network=es_default docker.elastic.co/elasticsearch/elasticsearch:7.3.0 curl --cacert /certs/ca/ca.crt -u elastic:                    # replace with the empty string https://es01:9200

#GENERAR CERTIFICADOS PARA KIBANA Y JUPYTER (autoridades)
openssl req -newkey rsa:2048 -nodes -keyout kibana.key -out kibana.csr
openssl req -newkey rsa:2048 -nodes -keyout jupyter.key -out jupyter.csr

#self-signed
openssl req -newkey rsa:2048 -nodes -keyout kibana.key -x509 -days 365 -out kibana.crt

#localhost
openssl req -x509 -out kibana.crt -keyout kibana.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

openssl x509 \
       -in kibana.crt \
       -signkey kibana.key \
       -x509toreq -out kibana.csr


       

openssl req -new -nodes -newkey rsa:2048 -keyout kibana.key -out kibana.csr -subj "/C=US/ST=YourState/L=YourCity/O=Example-Certificates/CN=localhost"

openssl x509 -req -sha256 -days 1024 -in kibana.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile domains.ext -out kibana.crt