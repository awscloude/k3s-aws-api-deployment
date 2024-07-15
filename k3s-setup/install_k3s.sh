#!/bin/bash

# Wait for EC2 instances to initialize

# Replace with your server's private IP
K3S_SERVER_PRIVATE_IP="your_server_private_ip"
# Replace with your k3s server token
K3S_TOKEN="your_k3s_token"

# Install k3s server on the server instance
ssh -o "StrictHostKeyChecking no" ec2-user@$K3S_SERVER_PRIVATE_IP "curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='server' sh -s -"

# Install k3s agent on each agent instance
# Replace with your agent's private IPs
K3S_AGENT_PRIVATE_IPS=("your_agent_private_ip1" "your_agent_private_ip2")

for IP in "${K3S_AGENT_PRIVATE_IPS[@]}"
do
    ssh -o "StrictHostKeyChecking no" ec2-user@$IP "curl -sfL https://get.k3s.io | K3S_URL=https://$K3S_SERVER_PRIVATE_IP:6443 K3S_TOKEN=$K3S_TOKEN sh -s -"
done

