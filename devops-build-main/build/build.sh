#!/bin/bash

IMAGE_NAME="my-react-app"
IMAGE_TAG="latest"
DOCKERFILE_PATH="."
docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKERFILE_PATH/Dockerfile $DOCKERFILE_PATH
if [ $? -eq 0 ]; then
  echo "Docker image '$IMAGE_NAME:$IMAGE_TAG' built successfully!"
else
  echo "Failed to build Docker image '$IMAGE_NAME:$IMAGE_TAG'"
  exit 1
fi
