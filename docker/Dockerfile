ARG CUDA_VERSION=11.2.2
ARG OS_VERSION=18.04
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${OS_VERSION}

LABEL maintainer = "drg@ics.uci.edu"

# Important reference
# https://github.com/NVIDIA/TensorRT/blob/master/docker/ubuntu-cross-aarch64.Dockerfile

RUN apt-get update 
# For all the sources
RUN apt-get install -y wget unzip
RUN apt-get clean

RUN mkdir -p /workspace
WORKDIR /workspace


# Install Cmake
RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4-Linux-x86_64.sh && \
    chmod +x cmake-3.14.4-Linux-x86_64.sh && \
    ./cmake-3.14.4-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license && \
    rm ./cmake-3.14.4-Linux-x86_64.sh


RUN cd /workspace
# Install cuda-cross
COPY jetpack-files jetpack-files
RUN dpkg -i jetpack-files/cuda-repo-cross-aarch64*.deb jetpack-files/cuda-repo-ubuntu*_amd64.deb \
    && apt-get update \
    && apt-get install -y cuda-cross-aarch64 \
    && rm -rf /var/lib/apt/lists/*

CMD [ "bash", "/workspace/build.sh" ]