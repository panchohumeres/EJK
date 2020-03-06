FROM jupyter/base-notebook

RUN python --version

RUN conda install --quiet --yes -c \
    conda-forge pandas \
    pymongo \
    matplotlib \
    seaborn


RUN pip install -U elasticsearch


VOLUME /home/jovyan/ 
WORKDIR /home/jovyan/ 