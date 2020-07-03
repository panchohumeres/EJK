# EJK
## Business Intelligence Stack with Elasticsearch, Kibana and Jupyter Notebooks
![enter image description here](https://fhumeres.s3-sa-east-1.amazonaws.com/EJK.png)
Business Intelligence stack, based on **Elasticsearch-Kibana** for **data warehousing** and **visualization**, and **Jupyter Notebooks** for development of automated **ETL** (Extract, Transform, Load) routines.

### Components:
 - **Elasticsearch**: Two-node Elasticsearch 7.2 Cluster, with native [REST API](https://www.elastic.co/guide/en/elasticsearch/reference/current/rest-apis.html) available in its endpoint.
 - **Jupyter Notebook**: Jupyter Container, derived from [Project Jupyter's Base Docker Image](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html), supercharged with [Supercronic](https://github.com/aptible/supercronic) and [Papermill](https://papermill.readthedocs.io/en/latest/) for enabling the automatic scheduling of python 3 ETL scripts.
 - **Kibana**: Kibana  7.2 Container, which interacts with the Elasticsearch cluster, sharing TSL Certificates (for internal communication) and X-Pack.
 - **Nginx:** Nginx service built from [Nginx official Docker image](https://hub.docker.com/_/nginx). Used for enabling **https** on Kibana and Jupyter endpoints, and Elasticsearch REST API.
 - **Certbot:** Custom docker container for configuration of **https** SSL certificates, and automating its renewal. Based on [nginx-certbot project](https://github.com/wmnnd/nginx-certbot)

### Dependencies
 - Docker and Docker-compose.
 - node.js
 - npm
 - elastic dump [see install instructions](https://www.npmjs.com/package/elasticdump) 

## Setup 
 1. Create `.env` file and populate environment variables.Follow structure outlined in the [example .env file](example.env)
 2. `./bi-init.sh`--->Create the folders and internal TSL certificates necessary for **EJK** startup.
 3. Register 3 domains, for the Jupyter and Kibana endpoints, and the Elasticsearch REST API, all pointing to your **server/VM IP**.
 4. Change accordingly the environment variables on the `.env` file.
 5. `./certbot.sh`--->Create the SSL certificates and keystores for enabling **https** on the Kibana and Jupyter endpoints, and the Elasticsearch REST API.

## Startup
 6. `docker-compose up`--->Start the stack
 7. `docker-compose up jupyter es01 es02 kibana`---->Start the stack in local mode (without nginx nor certbot, for testing in local environment).
 8. `docker-compose up --build`--->Start the stack recreating the services after changes in environment variables.

### Backup Utilities
 - [**Elastic Dump**](https://www.npmjs.com/package/elasticdump): Node.js library for Elasticsearch index backup between clusters. Customized module in [backup_utils](./backup_utils/elastic_dump). Use `ebak.env` file with `elastic_backup.sh` for parametrized wrapper. See [ebak.env.EXAMPLE](./ebak.env.EXAMPLE) for example environment file.
 - [**Kibana Backup**](./backup_utils/kibana): Backup for Kibana objects in Python 3, based on [kibana-backup-simple project](https://github.com/selivan/kibana-backup-simple).

## File Structure

Relevant File structure
```
📦EJK
┣ 📂CRONTAB
┃ ┣ 📂logs
┃ ┃Logs folder, where crontab status and output of Jupyter ETL scripts are stored.
┃ ┗ 📜crontab.sh
┃   Crontab script, which runs on Jupyter container at startup. Edit for configuration of ETL scheduling.
┣ 📂ETL
┃  ETL scripts (jupyter notebooks)
┣ 📂backup_utils
┃ ┣ 📂elastic_dump
┃ ┃  Elastic dump utility (node.js).
┃ ┗ 📂kibana
┃   Kibana backup utility (python3)
┣ 📂certs
┃  Docker-compose files for creating TSL certificates for internal communications between Elasticsearch-Kibana.
┣ 📂jupyter
┃   Jupyter configuration files, including Dockerfile.
┣ 📂modules
┃  Custom python modules and classes.
┣ 📂nginx
┃  Nginx configuration files, including Dockerfile.
┃ ┣ 📂conf
┃ ┃ ┣ 📜nginx-docker-entrypoint.sh
┃ ┃ ┃   Script executed at nginx container startup. It substitutes parameters from .env file in virtual server configuration file.
┃ ┃ ┗ 📜nginx.conf.template
┃     Virtual server configuration file.
┣ 📜bi-init.sh
┃   Stack setup script.
┣ 📜certbot.sh
┃    Certbot setup script.
┣ 📜docker-compose.yml
┃    Stack docker-compose file.
┣ 📜ebak.env
┃    .env file for elastic dump utility.
┣ 📜.env
┃    .env file for EJK stack docker-compose file.
┗ 📜elastic_backup.sh
    Wrapper for elastic dump utility.
```
