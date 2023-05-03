FROM jupyter/datascience-notebook
MAINTAINER "GGX"

RUN git clone https://github.com/KarolisMart/SPECTRE.git && rm -rf SPECTRE/.git

# Install mamba
RUN conda install mamba -n base -c conda-forge
  
# Install env
RUN mamba env update -n base -f SPECTRE/environment.yml 
RUN mamba clean -ya




# RUN python -m ipykernel install --user --name=SPECTRE
# RUN mamba clean -a

# ADD src/analysis /workspace/analysis
# ADD configs /workspace/configs
# ADD src/diffusion /workspace/diffusion
# ADD src/models /workspace/models
# ADD ./data/qm9/qm9_pyg /workspace/data/qm9/qm9_pyg
# ADD *.py /workspace/

# expects you to to run the image with `docker run -e WANDB_API_KEY=$YOUR_API_KEY graphgendiff:latest`
# RUN cd DiGress/src && python main.py





# compile with (within the folder of Dockerfile):  docker build -t gerritgr/graphgenbaseline . (replace gerritgr with your username)
# start with: docker run -p 10000:8888 gerritgr/graphgenbaseline   # at my PC the default port doesn't work
