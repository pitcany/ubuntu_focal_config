### just an example -- modify as needed
# scp /etc/apt/sources.list.d/* yannik@ec2-34-220-133-240.us-west-2.compute.amazonaws.com:~/test

#instance_id=$1

#ip_address=$(aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
#echo ip_address=$ip_address

scp $1 ubuntu@44.242.139.77:$2
