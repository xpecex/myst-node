#!/bin/bash

# RELEASE LIST
RELEASES=(
    "0.47.2"
)

# GET LATEST
LATEST=$(curl -s "https://github.com/mysteriumnetwork/node/releases/latest" | cut -d'/' -f 8 | cut -d'"' -f 1)

# ARCHITECTURE LIST
ARCH=(
    "linux/amd64"
    "linux/arm/v7"
    "linux/arm64"
)

# DOCKER LOGIN
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin &> /dev/null

# BUILD RELEASES
for RELEASE in "${RELEASES[@]}"; do

    # IMAGE CONFIG AND ARGS
    GIT_NAME="$(git config --get remote.origin.url | sed 's/.*\/\([^ ]*\/[^.]*\).*/\1/')"
    GIT_REF="$(git rev-parse --short HEAD)"

    NAME="${GIT_NAME:-ALT_NAME}"
    VERSION="$RELEASE"
    BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
    VCS_REF="${GIT_REF:-ALT_REF}"
    PLATFORMS="$(echo ${ARCH[@]} | sed 's/ /,/g')"

    if [ "$RELEASE" = "$LATEST" ]; then
        docker buildx build \
            --push \
            --progress auto \
            --build-arg VERSION="$VERSION" \
            --build-arg VCS_REF="$VCS_REF" \
            --build-arg BUILD_DATE="$BUILD_DATE" \
            --platform "$PLATFORMS" \
            --tag "$NAME:$RELEASE" \
            --tag "$NAME:latest" \
            --cache-from "$NAME:latest" \
            .
    else
        docker buildx build \
            --push \
            --progress auto \
            --build-arg VERSION="$VERSION" \
            --build-arg VCS_REF="$VCS_REF" \
            --build-arg BUILD_DATE="$BUILD_DATE" \
            --platform "$PLATFORMS" \
            --tag "$NAME:$RELEASE" \
            --cache-from "$NAME:$RELEASE" \
            .
    fi

done

