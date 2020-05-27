# docker-elastic-kibana-jupyter MVP BI WORK

## Componentes del Stack (empaquetado en docker-compose)

![Arquitectura Stack BI Work](Arquitectura_.png)


* BD Elasticsearch con dos nodos ("es01" y "es02" en docker-compose), puerto 9200.
* Kibana, puerto 5601
* Jupyter Notebooks (Anaconda Python 3), para ETL, puerto 8888
* Nginx, con reversy proxies para puertos 5601,8888 y 9200 (para servir Kibana, Elasticsearch y Jupyter Notebooks con sus propios dominios y certificados).
* Contenedor Certbot, que automáticante monitorea los certificados Letsencrypt SSL / TSL, y los actualiza cuando es necesario. También se utiliza para generar los certificados (junto con contenedor Nginx).
* En puerto 8080, Kibana en modo read-only (usuario anónimo)----->Deshabilitado por el momento
* Data de Elasticsearch persiste en Volúmenes externos, montadas en carpeta del host.
* Notebooks de Jupyter persisten en carpeta montada en host.

## Inicializar stack
Seguir esta secuencia de comandos:
* **generar certificados para comunicación interna de elastic-kibana (ejecutar una sóla vez)** docker va a generar automáticamente la red especificada en el archivo -env (variable PROJECT_NAME) y los volumenes de certificados<br/>
	* 1. crear directorio que va a contener certificados en volumen externo correspondiente (mkdir certs)
	* 2. docker-compose -f create-certs.yml run --rm create_certs
	* **certificados para ip** : docker-compose -f create-certs-http.yml run --rm create_certs-------->cambiar parámetros en archivo **ip_dns_keygen.yml**.
* **cambiar límite memoria virtual del host para elasticsearch)**, sin esta configuración los contenedores de elasticsearch no se levantan<br/>
sudo sysctl -w vm.max_map_count=262144
* docker-compose up

## Stack de Pruebas (útil para levantar dos clústers en paralelo)
* Se han generado archivos compose de pruebas, que permiten generar una nueva red del stack EJK y contenedor para generar certificados, en distintos puertos, y en otro volumen externo, con la ruta "dummy" apendizada a la especificada en el archivo .env (para los contenedores de elasticsearch, kibana y los certificados.). Pasos para ejecutar:
	* 1. crear directorio que va a contener certificados en volumen externo correspondiente, apendizado a ruta de path especificada en .env (mkdir dummy y mkdir dummy/certs).
	* 2. copiar permisos de volumen externo que esté funcionando con docker-compose default.
	* 3. docker-compose -f create-certs_dummy.yml -p dummy run --rm create_certs
	* 4. docker-compose -f docker-compose_dummy.yml -p dummy up
	* parar contenedores------>docker-compose -f docker-compose_dummy.yml -p dummy stop

### Respalda data, scripts:
* docker_volume_backup.sh | respaldar volúmenes de docker
* docker_volume_restore.sh | restaurar volúmenes de docker (no probado con volúmenes extenos)
* docker_volume_backup_restore.sh | ambos (respaldar y restaurar)

### generar contraseña (hash) para jupyter notebook
ejecutar comandos en esta secuencia:
* docker-compose start jupyter
* docker-compose exec jupyter bash
* ipython
* passwd()
* ingresar password y copiar y pegar hash en archivo .env (variable "JUPYTER_PSSWD")
* exit

## Diccionario de Datos:
Diccionario de datos disponible en HTML, construido con Sphinx. Para ver:
* https://panchohumeres.gitlab.io/_data_dict ----->preguntar por psswd
* Alternativa:
	1. clonar repositorio en entorno local
	2. acceder a diccionario en ./data_dict/build/index.html
	3. Documentación sobre sphinx disponible en: ./docs/shpinx

## TODO LIST:
* agregar las siguientes librerías al dockerfile del contenedor de jupyter (comandos):
    * conda install pymongo
* agregar en docker-compose rutina para que kibana espere a contenedores de elasticsearch antes de iniciarse.

## TROUBLESHOOTING:
* Al momento de migrar la data de elasticsearch-kibana en volumen externo, de un host a otro, puede ocurrir un error al volver a levantar el docker-compose:
	* Error (como se ve en log de Docker, contenedor KIbana): "FATAL [search_phase_execution_exception] all shards failed".
	* Esto ocurre por que elastic no alcanza a crear los "shards" para alojar el índice de kibana (que tiene la config. de los dashboards y visualizaciones), antes que se termine de levantar el contenedor de kibana.
	* Para solucionarlo, al migrar la data desde un host a otro, antes hay que borrar las imágenes de todos los nodos de elasticsearch, y de kibana.
	* Documentación en: https://github.com/elastic/kibana/issues/25027
* En el panel de "Developers" de Kibana (para probar queries de Elasticsearch), no se deben poner espacios entre la cabecera del método, y el "body" de la query.
* Para cambiar el **timefield**, de un **index pattern** en **kibana**, una vez que ya se ha creado, se debe hacer a través de queries a elastic. Ver: https://github.com/elastic/kibana/issues/9212, y las queries de ejemplo correspondientes que se han dejado en la documentación.
* **Contenedor de Pruebas/Migración de data**: Se recomienda para contenedores de prueba, o al migrar data de un clúster a otro, empezadas desde cero, crear una nueva carpeta para volumen externo de los datos de elasticsearch y kibana, y cambiar los permisos de esta manera, ver https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html:
	* **Copiar permisos de una carpeta existente que funcione**
		* sudo chmod -R --reference=<carpeta_origen> <carpeta_destino>
		* sudo chown -R --reference=<carpeta_origen> <carpeta_destino>
	* **Cambiar permisos para que elasticsearch funcione en producción**
		* sudo chmod -R g+rwx <carpeta_destino>
		* sudo chgrp -R 1000 <carpeta_destino>
		* sudo chown -R 1000 <carpeta_destino>

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
** **Revisar documentación adicional en:**
https://github.com/panchohumeres/panchoMan
