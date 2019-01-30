#!/bin/sh
IMAGE=mylatex:alpine
exec docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data "$IMAGE" "$@"
