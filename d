#!/bin/bash

# local setings
IMG_NAME=aerlaut/grav-base
HOST=0.0.0.0
PORT=80
TEST_CONTAINER_NAME=grav-base-test

if [ "$1" == 'build' ]; then

  # echo ask for tag
  if [ -n "$2" ]; then

    echo "Building image : $IMG_NAME:$2"
    docker rmi -f "$IMG_NAME":"$2"
    docker build . -f Dockerfile -t "$IMG_NAME":"$2"

  else

    echo "Building image : $IMG_NAME:lastest"
    docker rmi -f "$IMG_NAME":latest
    docker build . -f Dockerfile -t "$IMG_NAME":latest

  fi

elif [ "$1" == 'up' ]; then

  docker kill $TEST_CONTAINER_NAME
  docker run --rm -p $HOST:$PORT:80 --name $TEST_CONTAINER_NAME $IMG_NAME
  echo "Container $TEST_CONTAINER_NAME running at http://$HOST:$PORT"

elif [ "$1" == 'down' ]; then

  docker kill $TEST_CONTAINER_NAME
  echo "Container $TEST_CONTAINER_NAME killed"

elif [ "$1" == 'sh' ]; then

  docker exec -it "$TEST_CONTAINER_NAME" /bin/sh

fi
