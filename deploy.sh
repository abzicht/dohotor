#!/bin/bash
docker build -t dohotor ./
docker stack deploy --compose-file docker-stack.yml dohotor
