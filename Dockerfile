FROM jupyter/datascience-notebook
LABEL maintainer="GGX"

WORKDIR /app
RUN git clone https://github.com/KarolisMart/SPECTRE.git && rm -rf SPECTRE/.git

# Install mamba
RUN conda install mamba -n base -c conda-forge

# Install env
RUN mamba env update -n base -f /app/SPECTRE/environment.yml && \
    mamba clean -ya



# compile with (within the folder of Dockerfile):  docker build -t gerritgr/graphgenbaseline . (replace gerritgr with your username)
# start with: docker run -p 10000:8888 gerritgr/graphgenbaseline   # at my PC the default port doesn't work
