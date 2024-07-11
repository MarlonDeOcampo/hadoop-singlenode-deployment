#!/bin/bash
echo "--------------------------------------------------------------------------------------------------------------"
echo "             HADOOP DEPLOYMENT                                                                           "
echo "--------------------------------------------------------------------------------------------------------------"

if [ "x$(docker service ls | grep local-registry)" == x ]; then
  echo "Adding Local Registry Server if not present....."
  docker network create --driver overlay hadoop-net
  docker service create --name local-registry --publish published=5001,target=5001 --network hadoop-net registry:2
  echo "Local Registry Server Added.."
  echo "-------------------------------------------------------\n"
fi

echo "1- Start to push on registry the nodename docker image ..."
docker compose -f hadoop-build.yml build
docker compose -f hadoop-build.yml push
echo "(1)End to build and push nodename image to registry."
echo "-------------------------------------------------------\n"