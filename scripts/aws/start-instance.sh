#!/bin/bash

yourinstanceid=i-0fae8bdd94c5e8f84
#yourinstanceid=$1
aws ec2 start-instances --instance-ids $yourinstanceid
