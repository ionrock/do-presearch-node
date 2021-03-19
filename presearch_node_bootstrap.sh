#!/bin/bash

set -xe

echo "Installing the docker repo"

apt-get update && apt-get install -yq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update && apt-get install -yq docker-ce docker-ce-cli containerd.io

echo "Start up presearch!"

docker run -d --name presearch-auto-updater \
       --restart=unless-stopped \
       -v /var/run/docker.sock:/var/run/docker.sock \
       containrrr/watchtower --cleanup \
       --interval 300 presearch-node

docker run -dt \
       --name presearch-node \
       -v presearch-node-storage:/app/node \
       -e REGISTRATION_CODE=38bf947dd0fc105bc614ea49a3daa01a presearch/node

echo "We should be running!"
docker ps
