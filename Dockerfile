FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ARG user_name
ARG user_id
ARG group_id
ARG workdir
ARG homedir

# Install prerequisite tools and libraries
RUN apt-get update && \
    apt-get install -y build-essential apt-transport-https gnupg sudo wget curl unzip vim git cmake gdb htop libgl1-mesa-dev libglew-dev

# Install bazel
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg && \
    mv bazel-archive-keyring.gpg /usr/share/keyrings && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
    apt-get update && \
    apt-get install -y bazel

ENV DISPLAY=:1

RUN mkdir -p ${workdir}
WORKDIR ${workdir}

RUN touch ${homedir}/.bashrc
RUN echo "alias ll='ls -alF --color=auto'" >> ${homedir}/.bashrc
RUN echo "export CUDA_PATH=/usr/local/cuda-11.3" >> ${homedir}/.bashrc

RUN groupadd -g ${group_id} ${user_name} && \
    useradd -u ${user_id} -g ${group_id} -ms /bin/bash ${user_name}
USER ${user_name}
