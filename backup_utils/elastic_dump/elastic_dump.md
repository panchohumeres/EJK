### Fuentes:
* https://www.npmjs.com/package/elasticdump
* https://github.com/taskrabbit/elasticsearch-dump
* https://hub.docker.com/r/taskrabbit/elasticsearch-dump/dockerfile

### Descargar imagen docker:
    docker pull taskrabbit/elasticsearch-dump
### Pruebas:
 * Con **docker-compose** en este directorio.
 * "docker build -t elastic_dump ." para build de imagen de pruebas (del **Dockerfile** en este directorio).
 * **Dockerfile** en este directorio no tiene entrypoint, es para pruebas en entorno interactivo.
 * "docker run -it elastic_dump sh" para correr imagen de pruebas en modo interactivo, con shell (a partir de **Dockerfile** en este directorio).
 * apk add curl ------>instalar curl en el contenedor
 * "docker run -ti --entrypoint=/bin/sh taskrabbit/elasticsearch-dump -i" para correr **imagen original (rabbit)** en modo interactivo.
 * docker run -v {CERTS_PATH_ABSOLUTE}:/{CONTAINER_MOUNT_PATH} --network=host -ti --entrypoint=/bin/sh taskrabbit/elasticsearch-dump -i ------>mismo caso anterior, montando volumen (se recomienda se llame "tmp" el del contenedor)

### Ejemplo estándar:
    docker run --rm -ti taskrabbit/elasticsearch-dump \
      --input=http://production.es.com:9200/my_index \
      --output=http://staging.es.com:9200/my_index \
      --type=data

## **Ejemplo Migrar índice desde dentro del contenedor "rabbit" (imagen original)**
      elasticdump \
      --input=https://{ELASTIC_USER}:{ELASTIC_PSSWD}@localhost:{PUERTO_1}/{INDEX} \
      --input-ca=/{path_certs_1}/certs/ca/ca.crt \
      --output=https://{ELASTIC_USER}:{ELASTIC_PSSWD}@localhost:{PUERTO_2}/{INDEX} \
      --output-ca=/tmp/{PATH_CERTS_2}/certs/ca/ca.crt \
      --tlsAuth \
      --type=data
* Se debe llamar el contenedor en modo interactivo, especificado --network=host, como se indica al principio.
* Se asume que **/tmp** es la carpeta en el contenedor donde se está montando el volumen, y que los endpoints de elastic se encuentran en **localhost**. Los path a certificados también pueden variar dependiendo de la configuración (es la default que se usa en este stack en particular).

## **Ejemplo Migrar índice llamando al contenedor "rabbit" (imagen original) desde host----->TODAVÍA NO FUNCIONA**
      docker run --net=host --rm -ti taskrabbit/elasticsearch-dump -v /home/francisco/Desktop/repos/data/mockup:/tmp \
      --input=https://{ELASTIC_USER}:{ELASTIC_PSSWD}@localhost:{PUERTO_1}/{INDEX} \
      --input-ca=/{path_certs_1}/certs/ca/ca.crt \
      --output=https://{ELASTIC_USER}:{ELASTIC_PSSWD}@localhost:{PUERTO_2}/{INDEX} \
      --output-ca=/tmp/{PATH_CERTS_2}/certs/ca/ca.crt \
      --tlsAuth \
      --type=data
* **NOTA**: Aún **NO FUNCIONA**.

## **Probar conexión a endpoints de elastic (debe funcionar dentro y fuera del contenedor rabbit):
* curl --cacert {CERTS_PATH}/certs/ca/ca.crt https://{ELASTIC_USER}:{ELASTIC_PASSWD}@localhost:{elastic_port}/{INDEX}
* Ver ejemplos de elastic queries con Curl en docs respectivos.
* Se asume endpoints están en localhost.

### **TROUBLESHOOTING**:
* Error "ERR! network getaddrinfo ENOTFOUND"----->Al hacer build de la imagen docker npm no puede encontrar la url de los paquetes (https://registry.npmjs.org/). Solución:
	1. Verificar que la URL es accesible desde el host (con ping).
	2. nmcli dev show | grep 'IP4.DNS' ------> Obtener servidor DNS del Host (si es que funciona)
	3. sudo /etc/docker/daemon.json------>Incluir IP del servidor DNS del host en config del deamon de docker: ```json {"dns": ["IP_SERV_DNS_HOST","192.168.4.1", "8.8.8.8", "ETC."]}```
	4. sudo service docker restart
	5. probar que config. funciona con docker-compose en la carpeta de elastic_dump
	* refs: 
		* https://stackoverflow.com/questions/39592908/error-getaddrinfo-enotfound-registry-npmjs-org-registry-npmjs-org443
		* https://l-lin.github.io/post/2018/2018-09-03-docker_ubuntu_18_dns/
		* https://stackoverflow.com/questions/24151129/network-calls-fail-during-image-build-on-corporate-network