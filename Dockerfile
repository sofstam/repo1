FROM continuumio/miniconda3:latest as condabuild
LABEL authors="Matt Bull" \
      description="Docker image containing all requirements for an Illumina ncov2019 pipeline"

COPY extras.yml /extras.yml
COPY environment.yml /environment.yml
RUN /opt/conda/bin/conda update conda && \
/opt/conda/bin/conda install mamba -c conda-forge && \
/opt/conda/bin/mamba env create -f /environment.yml

FROM debian:buster-slim
RUN apt-get update && \
apt-get install -y git procps && \
apt-get clean -y 
COPY --from=condabuild /opt/conda/envs/artic-ncov2019-illumina /opt/conda/envs/artic-ncov2019-illumina
ENV PATH=/opt/conda/envs/artic-ncov2019-illumina/bin:$PATH
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
