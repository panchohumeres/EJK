#SHELL=/bin/bash
#BASH_ENV=/home/<user>/.bashrc_conda
#* * * * * cd /home/<user>/PATH/TO/data-dictionary && conda activate conda-3-forge && ./init_data_dict.sh -m create && conda deactivate  > ./outputs/logs.txt 2>&1
05 * * * * papermill /home/jovyan/ /ETL/dashboards_gob/CKAN_to_elastic_encrypted.ipynb /home/jovyan/ /ETL/dashboards_gob/logs/CKAN_to_elastic_encrypted_`date +\%Y\%m\%d\%H\%M\%S`.ipynb