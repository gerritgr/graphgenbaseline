FROM jupyter/datascience-notebook
MAINTAINER "GGX"

RUN git clone https://github.com/cvignac/DiGress


RUN conda update -n base -y conda && conda install -n base -c conda-forge -y mamba #&&
RUN conda install -n base -c conda-forge graph-tool #&&
RUN mamba  install -y rdkit #&& 
RUN pip install pyyaml && pip install overrides imageio numpy scipy tqdm wandb hydra-core seaborn #&&
RUN pip install pytorch_lightning==1.6  torchmetrics torch==1.11 torchvision  --extra-index-url https://download.pytorch.org/whl/cu113 #&&
RUN pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://data.pyg.org/whl/torch-1.11.0+cu113.html
#RUN pip install pyyaml && pip install overrides imageio numpy scipy tqdm wandb hydra-core #&&
RUN cd DiGress/src/analysis/orca && g++ -O2 -std=c++11 -o orca orca.cpp
RUN pip install git+https://github.com/igor-krawczuk/mini-moses

RUN cd DiGress && pip install -e .


# ADD src/analysis /workspace/analysis
# ADD configs /workspace/configs
# ADD src/diffusion /workspace/diffusion
# ADD src/models /workspace/models
# ADD ./data/qm9/qm9_pyg /workspace/data/qm9/qm9_pyg
# ADD *.py /workspace/

# expects you to to run the image with `docker run -e WANDB_API_KEY=$YOUR_API_KEY graphgendiff:latest`
RUN cd DiGress && python main.py





# compile with (within the folder of Dockerfile):  docker build -t gerritgr/graphgenbaseline . (replace gerritgr with your username)
# start with: docker run -p 10000:8888 gerritgr/graphgenbaseline   # at my PC the default port doesn't work
