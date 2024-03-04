#!/bin/bash

sudo yum update -y && sudo yum install -y httpd
sudo systemctl start httpd
MYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`
sudo echo 'this is: '$MYIP | sudo tee /var/www/html/index.html > /dev/null