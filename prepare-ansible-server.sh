#!/urs/bin/env bash

apt update 
apt install ansible -y
apt install python3-pip -y 
pip install boto3 botocore 