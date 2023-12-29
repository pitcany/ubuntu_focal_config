#!/bin/bash

keypair=$USER  # or some name that is meaningful to you
publickeyfile=$HOME/.ssh/yannik.pub
regions=$(aws ec2 describe-regions \
  --output text \
  --query 'Regions[*].RegionName')

for region in $regions; do
  echo $region
  aws ec2 delete-key-pair \
    --region "$region" \
    --key-name "$keypair"
done
