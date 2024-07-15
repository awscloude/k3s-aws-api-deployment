#!/bin/bash

# AWS credentials and parameters
AWS_ACCESS_KEY="your_aws_access_key"
AWS_SECRET_KEY="your_aws_secret_key"
REGION="ap-southeast-1"
AMI="ami-0xxxxxxx"  # Replace with your desired Amazon Linux 2 AMI
INSTANCE_TYPE="t2.micro"  # Replace with your desired instance type
KEY_NAME="your_key_pair_name"  # Replace with your EC2 key pair name
SUBNET_ID="subnet-xxxxxxxx"  # Replace with your private subnet ID
SECURITY_GROUP_ID="sg-xxxxxxxx"  # Replace with your security group ID allowing SSH and k3s ports

# Launch EC2 instances
aws ec2 run-instances \
    --region $REGION \
    --image-id $AMI \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --subnet-id $SUBNET_ID \
    --security-group-ids $SECURITY_GROUP_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=k3s-server},{Key=Environment,Value=production}]" \
    --associate-public-ip-address false \
    --query 'Instances[0].InstanceId' \
    --output text

aws ec2 run-instances \
    --region $REGION \
    --image-id $AMI \
    --count 2 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --subnet-id $SUBNET_ID \
    --security-group-ids $SECURITY_GROUP_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=k3s-agent},{Key=Environment,Value=production}]" \
    --associate-public-ip-address false \
    --query 'Instances[*].InstanceId' \
    --output text

