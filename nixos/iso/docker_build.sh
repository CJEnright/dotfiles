#!/bin/sh

set -ex

# Choose which public key to use
read -p "Enter SSH public key location (~/.ssh/id_ed25519.pub): " pub_key_loc
# If pub_key_loc wasn't set, then use the default location (~/.ssh/id_ed25519.pub)
pub_key_loc=${pub_key_loc:-~/.ssh/id_ed25519.pub}

# Create the docker container with the SSH public key as an argument (the
# dockerfile will write it into a file which nix-build will read from)
docker build -f iso.docker --tag nix_iso_builder . --build-arg SSH_PUB_KEY="$(cat $pub_key_loc)"

# Get the container ID and copy out the resulting iso
nix_iso_container_id=$(docker create nix_iso_builder:latest)
docker cp $nix_iso_container_id:/result/ .
