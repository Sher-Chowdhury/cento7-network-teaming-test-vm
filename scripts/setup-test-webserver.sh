#!/bin/bash

echo "####################################################"
echo "####### About to run setup-test-webserver.sh #######"
echo "####################################################"

yum install -y epel-release || exit 1
yum group install -y 'gnome desktop' || exit 1
yum install -y httpd || exit 1
systemctl enable httpd || exit 1
systemctl start httpd || exit 1

systemctl isolate graphical.target & 

systemctl set-default graphical.target || exit 1


exit 0
