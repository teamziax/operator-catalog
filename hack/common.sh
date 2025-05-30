#!/bin/bash

# Use podman or docker as container engine
# Find which are available
if command -v podman &> /dev/null; then
    CONTAINER_ENGINE=podman
elif command -v docker &> /dev/null; then
    CONTAINER_ENGINE=docker
else
    echo "Neither podman nor docker is available. Please install one of them."
    exit 1
fi