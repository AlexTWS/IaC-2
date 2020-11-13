# Scalable Website
![alt text](https://github.com/MrKhalidJ/IaC/blob/main/2.scalable_website/diagram_p2.png?raw=true)

Applying this terraform project witll create the following:
* Network:
  * VPC
  * Two public subnets for high availability
  * Routing table
  * Associate Routing table with public subnets
* Resources:
  * Internet gateway attached to the VPC
  * Application load balancer
  * Target group
  * Launch configuration for the auto scaling group
  * Auto scaling group associated with the target group that spans from 2 to 4 instances for scalability
  * Security groups for the load balancer and target group
