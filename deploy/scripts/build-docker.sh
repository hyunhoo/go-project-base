#!/bin/bash

IMAGE_NAME="project"
IMAGE_TAG="${IMAGE_NAME}:latest"

function build() {
  docker build -t "${IMAGE_TAG}" .

  mkdir -p build
  docker image save "${IMAGE_TAG}" -o build/${IMAGE_NAME}.tar
}

build
