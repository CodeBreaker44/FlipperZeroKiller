#!/bin/bash
docker rm -f flipper_killer
docker rmi -f flipper_killer
docker build -t flipper_killer .
docker run --name=flipper_killer --rm -p1337:1337 -it flipper_killer