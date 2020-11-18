#!/bin/sh

set -ex

docker build -f iso.docker --tag nix_iso_builder . --build-arg SSH_PUB_KEY="$(cat ~/.ssh/id_ed25519.pub)"
nix_iso_container_id=$(docker create nix_iso_builder:latest)
docker cp $nix_iso_container_id:/result/ .
