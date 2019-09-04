#!/usr/bin/env bash
set -Eeuxmo pipefail
DIR="$(dirname "$(command -v greadlink >/dev/null 2>&1 && greadlink -f "$0" || readlink -f "$0")")"

# --- Config
IMAGE_NAME="deb-s3"

# ---
VERSION=$(cat "$DIR/VERSION")

docker build -t "$IMAGE_NAME:$VERSION" "$DIR"

DOCKER_REGISTRY="cmaster11"

echo "Using Docker registry URL $DOCKER_REGISTRY"

docker tag "$IMAGE_NAME:$VERSION" "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION"
docker push "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION"