#!/usr/bin/env bash
set -eu

python3 /home/jovyan/.jupyter/password.py
jupyter-notebook --NotebookApp.password=$(cat /tmp/sha1-psswd) --NotebookApp.allow_origin=${JUPYTER_ALLOW_ORIGIN}




#exec "$@"