#!/bin/bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.9/2023-01-11/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin
kubectl version
yum remove awscli 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --update
#sudo eksctl create cluster --name anji --region ap-south-1 --node-type t2.micro --nodes-min 1
#it used to create the cluster direct provisiong
aws eks update-kubeconfig --region us-east-1 --name valaxy-eks-01
