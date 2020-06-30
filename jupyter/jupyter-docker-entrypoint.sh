#!/usr/bin/env bash
set -eu

supercronic -split-logs /home/jovyan/ /CRONTAB/crontab.sh 1>/home/jovyan/ /CRONTAB/logs/cron.log & SUPERCRONIC_ID=$!
python3 /home/jovyan/.jupyter/password.py
jupyter-notebook --NotebookApp.password=$(cat /tmp/sha1-psswd) --NotebookApp.allow_origin=${JUPYTER_ALLOW_ORIGIN}




#exec "$@"