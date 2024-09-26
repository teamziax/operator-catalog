#!/bin/bash

OPERATOR=$1
VERSION=$2
BUILD_IMAGE=$3

# default build image to false
if [ -z "$BUILD_IMAGE" ]; then
  BUILD_IMAGE=false
else
  BUILD_IMAGE=true
fi

SED_CMD='sed'
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_CMD='gsed'
fi

cd "$(dirname "$0")"
rm catalog/$OPERATOR/$OPERATOR.v*.yaml
opm render quay.io/ziax/$OPERATOR-bundle:$VERSION -o yaml > catalog/$OPERATOR/$OPERATOR.v$VERSION.yaml
cp catalog-templates/$OPERATOR.yaml catalog/$OPERATOR/$OPERATOR.yaml
$SED_CMD -i 's/$VERSION/'$VERSION'/g' catalog/$OPERATOR/$OPERATOR.yaml
if [ "$BUILD_IMAGE" = true ]; then
  docker build -f catalog.Containerfile -t quay.io/ziax/operator-catalog:latest . --platform=linux/amd64
  docker push quay.io/ziax/operator-catalog:latest
fi
# git add .
# git commit -m "Update $OPERATOR to version $VERSION"
# git push