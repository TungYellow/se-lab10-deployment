#!/usr/bin/env bash
# Exercise 6 - Deploy to AWS (ECR + Elastic Beanstalk). Replace the values below.
set -e
REGION=ap-southeast-1
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPO=myaspnetcoreapp
aws ecr create-repository --repository-name $REPO --region $REGION || true
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
docker tag myaspnetcoreapp $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:latest
# Elastic Beanstalk: Dockerrun.aws.json points to the ECR image
cat > Dockerrun.aws.json <<JSON
{ "AWSEBDockerrunVersion": "1",
  "Image": { "Name": "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:latest", "Update": "true" },
  "Ports": [ { "ContainerPort": 80 } ] }
JSON
eb init se-lab10 --platform docker --region $REGION
eb create se-lab10-env
eb open
