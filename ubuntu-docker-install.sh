#!/bin/sh
set -e

YELLOW='\033[0;33m'
NC='\033[0m' # reset color

echo "${YELLOW}[INFO] Updating system...${NC}"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "${YELLOW}[INFO] Installing dependencies...${NC}"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    net-tools \
    make \
    unzip \
    lsb-release \
    software-properties-common

echo "${YELLOW}[INFO] Adding Docker’s official GPG key...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo "${YELLOW}[INFO] Adding Docker repository...${NC}"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "${YELLOW}[INFO] Installing Docker Engine...${NC}"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "${YELLOW}[INFO] Adding current user ($USER) to docker group...${NC}"
sudo usermod -aG docker "$USER"

echo "${YELLOW}[INFO] Docker installation finished!${NC}"
echo "-----------------------------------"
docker --version
docker compose version
echo "${YELLOW}[INFO] Please log out and log back in (or run 'newgrp docker') to use Docker without sudo.${NC}"
