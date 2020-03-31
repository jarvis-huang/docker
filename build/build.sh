#!/usr/bin/env bash


group_id=$(cut -d: -f3 < <(getent group sudo))
WORKSPACE="/home/jhuang"

docker build \
	--build-arg user=$USER\
	--build-arg uid=$UID\
	--build-arg gid=$group_id\
	--build-arg home=$HOME\
	--build-arg shell=$SHELL\
	--build-arg workspace=$WORKSPACE\
	--rm -f cuda9_tf112.Dockerfile -t jhuang/cuda9_tf112:0.1 . 
