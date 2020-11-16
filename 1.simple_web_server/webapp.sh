#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo '<h1 style="text-align: center;">Hello from <span style="color: #623ce4;">Terraform</span>!</h1>' >> /var/www/html/index.html