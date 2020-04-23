# base image
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Arguments
ARG user
ARG uid
ARG gid
ARG home
ARG shell
ARG workspace

# Some common environmenta variables that Python uses
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y build-essential cmake pkg-config time

RUN apt-get install -y curl python3 python3-pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

#RUN python3 -m pip install futures==3.2.0

# Install a specific version of TensorFlow
RUN python3 -m pip install --no-cache-dir tensorflow-gpu==1.12.0

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# You may also install anything else from pip like this
ADD requirements.txt .
RUN python3 -m pip install -r requirements.txt

RUN apt-get update && apt-get install -y libsm6 libxext6 libxrender-dev python3.5-tk libboost-all-dev

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set up the time zone, for correct rosbag time
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

RUN mkdir -p /home/${user} && \
    echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> /etc/passwd && \
    echo "${user}:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/${user}

USER ${user}
ENV HOME /home/${user}
ENV WORKSPACE /home/${user}

