#!/bin/bash

set -e -x

source ./hack/common.sh

# 1 argument: tag

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <tag>"
    exit 1
fi

TAG=$1
IMG_OPERATOR="quay.io/ziax/operator-catalog:${TAG}"

#Build and push the catalog index
$CONTAINER_ENGINE build -t "${IMG_OPERATOR}" -f catalog.Containerfile .
$CONTAINER_ENGINE push "${IMG_OPERATOR}"