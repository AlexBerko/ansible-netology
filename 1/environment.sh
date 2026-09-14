#!/bin/bash

echo "Installing dependencies..."

# Install and run CentOS with python
docker run -d --name centos7 quay.io/centos/centos:stream9 sleep infinity > /dev/null 2>&1
docker exec centos7 yum install -y python3 > /dev/null 2>&1

# Install and run Ubuntu with python
docker run -d --name ubuntu ubuntu:latest sleep infinity > /dev/null 2>&1
docker exec ubuntu sh -c "apt-get update && apt-get install -y python3" > /dev/null 2>&1

# Install and run Fedora
docker run -d --name fedora_docker pycontribs/fedora:latest sleep infinity > /dev/null 2>&1

# Wait until dependencies installing
sleep 5

echo "Done."

ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

echo "Removing Docker containers..."
docker rm -f ubuntu centos7 fedora_docker > /dev/null 2>&1

echo "Done."