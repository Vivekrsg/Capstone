#!/bin/bash

IMAGE_NAME="my-react-app"
IMAGE_TAG="latest"

SERVER_HOST="example.com"
SERVER_USER="username"

REMOTE_DIR="/path/to/remote/directory"

docker build -t $IMAGE_NAME:$IMAGE_TAG .

if [ $? -eq 0 ]; then
  echo "Docker image '$IMAGE_NAME:$IMAGE_TAG' built successfully!"
else
  echo "Failed to build Docker image '$IMAGE_NAME:$IMAGE_TAG'"
  exit 1
fi

docker save $IMAGE_NAME:$IMAGE_TAG | gzip > $IMAGE_NAME.tar.gz

scp $IMAGE_NAME.tar.gz $SERVER_USER@$SERVER_HOST:$REMOTE_DIR

ssh $SERVER_USER@$SERVER_HOST "
  cd $REMOTE_DIR
  gunzip $IMAGE_NAME.tar.gz
  docker load < $IMAGE_NAME.tar
  docker run -d -p 80:80 --name $IMAGE_NAME $IMAGE_NAME:$IMAGE_TAG
"

rm $IMAGE_NAME.tar.gz
