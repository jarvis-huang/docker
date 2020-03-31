#!/usr/bin/env bash

xhost +
WORKSPACE="/home/jhuang"

# Running in local machine
nvidia-docker run\
	--net=host\
	-e SHELL\
	-e DISPLAY=unix:0.0\
	-e NO_AT_BRIDGE=1 \
	-e QT_X11_NO_MITSHM=1\
	-v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged\
	-v /dev:/dev \
	-v /tmp/.docker.xauth:/tmp/.docker.xauth \
	-w $WORKSPACE \
	-e XAUTHORITY=/tmp/.docker.xauth \
	-v `pwd`:$WORKSPACE \
	-it --rm jhuang/cuda9_tf112:0.1 /bin/bash
