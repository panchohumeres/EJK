#!/bin/bash

#changing host virtual memory limit to 262144
sudo sysctl -w vm.max_map_count=262144

#bringing up containers
docker-compose up jupyter es01 es02 kibana