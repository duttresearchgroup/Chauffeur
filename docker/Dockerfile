FROM nvidia/cuda:11.2.2-devel-ubuntu18.04
LABEL maintainer = "drg@ics.uci.edu"

RUN apt-get update 
RUN apt-get install -y cmake
RUN apt-get clean

RUN mkdir -p /workspace
WORKDIR /workspace

CMD [ "bash", "/workspace/build.sh" ]