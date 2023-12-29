#!/bin/bash

ip_address=44.242.139.77

ssh -L 8888:localhost:8888 -L 5902:localhost:5902 yannik@$ip_address
#Or try this
#ssh -L 8888:localhost:8888 -L 5902:localhost:5902 ubuntu@$ip_address

