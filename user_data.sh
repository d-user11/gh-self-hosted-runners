#!/bin/bash

sudo apt get update && sudo apt get upgrade -y
sudo apt install -y jq unzip


### INSTALL AWS CLI

cd / && mkdir aws_cli && cd aws_cli || return
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

### INSTALL DOCKER ###

cd / && mkdir docker_install && cd docker_install || return

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh ./get-docker.sh

sudo groupadd docker
sudo usermod -aG docker ubuntu

### CONFIGURE GITHUB SELF-HOSTED RUNNER ###

cd / && mkdir actions-runner && cd actions-runner || return

RUNNER_PACKAGE_URL=$(
    curl -s -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${access_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/${owner}/${repo}/actions/runners/downloads | \
    jq -r -c '.[] | select( .os | contains("linux")) | select( .architecture | contains("x64")) | .download_url'
)

echo "RUNNER_PACKAGE_URL: $RUNNER_PACKAGE_URL"

curl -o actions-runner-linux.tar.gz -L "$RUNNER_PACKAGE_URL"

tar xzf ./actions-runner-linux.tar.gz

REGISTRATION_TOKEN=$(
    curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${access_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${owner}/${repo}/actions/runners/registration-token" | \
    jq -r '.token'
)

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)

RUNNER_ALLOW_RUNASROOT="1" ./config.sh \
    --url "https://github.com/${owner}/${repo}" \
    --token "$REGISTRATION_TOKEN" \
    --name "aws_gh_runner" \
    --labels "aws,docker,$INSTANCE_ID" \
    --replace

sudo ./svc.sh install
sudo ./svc.sh start
