#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# brew install manifest-tool


#read -s PASS

#docker login -u gadelkareem -p $PASS docker.io/v1/

# combine all architectures build steps in one loop
for arch in amd64 arm64v8; do
    docker build -t gadelkareem/radarr-extended:$arch --build-arg ARCH=$arch/ -f $arch.dockerfile .
    docker push gadelkareem/radarr-extended:$arch
done


manifest-tool push from-spec --ignore-missing multi-arch-manifest.yaml
