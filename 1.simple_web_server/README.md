# Simple Web Server
![alt text](https://github.com/MrKhalidJ/IaC/blob/main/1.simple_web_server/diagram_p1.png?raw=true)

This is a simple project that creates the following:
* Network:
  * VPC
  * Public subnet
  * Routing table
  * Associate Routing table with public subnet
* Resources:
  * Internet gateway attached to the VPC
  * EC2 instance placed in the puclic subnet and and configured using user data
  * Security groups for SSH access and web access to the EC2 instance

After applying, proceed to visit the EC2 IP address and check the web page.