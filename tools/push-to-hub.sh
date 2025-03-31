#!/bin/bash

# Define variables
IMAGE_NAME="anandbmuley/json-viewer:1.2.0"
IMAGE_NAME_LATEST="anandbmuley/json-viewer:latest"
DOCKERFILE_PATH="."

# Build the Docker image
echo "Building multi platform docker image $IMAGE_NAME..."
# docker build -t $IMAGE_NAME $DOCKERFILE_PATH
# docker image tag $IMAGE_NAME $IMAGE_NAME_LATEST

docker buildx build --no-cache --platform=linux/amd64,linux/arm64 -t $IMAGE_NAME_LATEST -t $IMAGE_NAME --push .

# Push the Docker image to Docker Hub
# echo "Pushing Docker image to Docker Hub..."
# docker tag $IMAGE_NAME_LATEST $IMAGE_NAME
# docker push $IMAGE_NAME
# docker push $IMAGE_NAME_LATEST

echo "Done."