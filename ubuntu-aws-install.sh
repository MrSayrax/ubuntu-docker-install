#!/bin/sh
set -e

YELLOW='\033[0;33m'
NC='\033[0m' # reset color

echo "${YELLOW}[INFO] Download and install AWS...${NC}"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install