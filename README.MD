# EJK
## Business Intelligence Stack with Elasticsearch, Kibana and Jupyter Notebooks
![enter image description here](https://fhumeres.s3-sa-east-1.amazonaws.com/EJK.png)
### Components:

 - **Elasticsearch**: Two-node Elasticsearch 7.2 Cluster, with native [REST API](https://www.elastic.co/guide/en/elasticsearch/reference/current/rest-apis.html) available in its endpoint.
 - **Jupyter Notebook**: Jupyter Container, derived from [Project Jupyter's Base Docker Image](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html), supercharged with [Supercronic](https://github.com/aptible/supercronic) and [Papermill](https://papermill.readthedocs.io/en/latest/) for enabling the automatic scheduling of python 3 ETL scripts.
 - **Kibana**: Kibana  7.2 Container, which interacts with the Elasticsearch cluster, sharing TSL Certificates (for internal communication) and X-Pack.
 - **Nginx:** Nginx service 

## Setup
 1. `./bi-init.sh`--->Create the folders and internal TSL certificates necessary for **EJK** startup.
 2. Register 3 domains, for the Jupyter and Kibana endpoints, and the Elasticsearch REST API, all pointing to your **server/VM IP**.
 3. Change accordingly the environment variables on the `.env` file.
 4. `./certbot.sh`--->Create the SSL certificates and keystores for enabling **https** on the Kibana and Jupyter endpoints, and the Elasticsearch REST API.
 
## Startup
 6. `docker-compose up`--->Start the stack
 7. `docker-compose up jupyter es01 es02 kibana`---->Start the stack in local mode (without nginx nor certbot, for testing in local environment).
 8. `docker-compose up --build`--->Start the stack recreating the services after changes in environment variables.

## File Structure

Relevant File structure
```
📦EJK
    ┃ 
    ┃
    ┣ 📂CRONTAB
    ┃ ┣ 📂logs
    ┣ 📂ETL
    ┣ 📂backup_utils
    ┃ ┣ 📂elastic_dump
    ┃ ┣ 📂kibana
    ┃ ┃ 
    ┣ 📂certs
    ┣ 📂jupyter
    ┃ kkkkk
    ┣ 📂modules
    ┣ 📂nginx
    ┃ ┣ 📂conf
    ┃ ┣ 📂examples
    ┣ 📜.gitignore
    ┣ 📜LICENSE
    ┣ 📜README.MD
    ┣ 📜bi-init.sh
    ┣ 📜certbot.sh
    ┣ 📜docker-compose.yml
    ┣ 📜ebak.env.EXAMPLE
    ┣ 📜elastic_backup.sh
```
