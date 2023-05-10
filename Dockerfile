FROM jupyter/datascience-notebook
LABEL maintainer="GGX"

RUN git clone https://github.com/KarolisMart/SPECTRE.git && rm -rf SPECTRE/.git

RUN apt-get update && \
    apt-get install -y python3.9

# Install mamba
RUN conda install mamba -n base -c conda-forge

RUN git clone https://github.com/gerritgr/graphgenbaseline.git

# Install env
RUN mamba env create  -f graphgenbaseline/spectre_environment.yml && \
    mamba clean -ya
#RUN mamba env create  -f SPECTRE/environment.yml && \
#    mamba clean -ya

RUN conda init bash
RUN conda init zsh
RUN eval "$(conda shell.bash hook)"

RUN mamba env update -n base -f SPECTRE/environment.yml && \
    mamba clean -ya


RUN conda install -c anaconda ipykernel && python -m ipykernel install --user --name=SPECTRE

# RUN cd SPECTRE && conda env update -n base -f environment.yml
# RUN conda install matplotlib=3.1.3 numpy=1.18.1 networkx=2.4 --yes --force-reinstall

# compile with (within the folder of Dockerfile):  docker build -t gerritgr/graphgenbaseline . (replace gerritgr with your username)
# start with: docker run -p 10000:8888 gerritgr/graphgenbaseline   # at my PC the default port doesn't work
