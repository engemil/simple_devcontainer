#!/bin/bash

# This script removes our devcontainers, that starts with "simple". It removes both containers and images.

# HOW-TO use:
# Change permission: chmod +x ./CLEAN.sh
# Execute: ./CLEAN.sh

# Function to stop and remove containers
remove_containers() {
    containers=$(docker ps -a --filter "name=simple" --format "{{.ID}}")
    if [ -z "$containers" ]; then
        echo "No containers found starting with 'simple'."
    else
        echo "Stopping and removing all our devcontainers starting with 'simple'."
        for container in $containers; do
            echo "Stopping container: $container"
            docker stop $container
            echo "Removing container: $container"
            docker rm $container
        done
    fi
}

# Function to remove images
remove_images() {
    images=$(docker images --filter=reference='simple*' --format "{{.ID}}")
    if [ -z "$images" ]; then
        echo "No images found starting with 'simple'."
    else
        echo "Removing images starting with 'simple'."
        for image in $images; do
            echo "Removing image: $image"
            docker rmi $image
        done
    fi
}

# Execute the functions
remove_containers
remove_images

echo "Operation completed."