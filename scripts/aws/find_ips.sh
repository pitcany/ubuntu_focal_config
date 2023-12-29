#!/bin/bash

#instance_id=i-0ed18636298ec875f
instance_id=$1
#aws ec2 describe-instances --output table
#aws ec2 describe-instance-status --instance-ids $yourinstanceid --output table

ip_address=$(aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo ip_address=$ip_address
#ip_address=$(aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
#echo $ip_address
