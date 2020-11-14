# Two-tier Application with RDS Database
![alt text](https://github.com/MrKhalidJ/IaC/blob/main/3.two_tier_with_rds/diagram_p3.png?raw=true)

This project will create the infrastructure for a scalable, and highly available two-tier architecture. Applying these configuration files will create the following:
* Network:
  * VPC
  * Two public subnets
  * Two private subnets
  * Routing table
  * Associate Routing table with public subnets
* Resources:
  * Internet gateway attached to the VPC
  * Application load balancer
  * Target group
  * Launch configuration for the auto scaling group
  * Auto scaling group associated with the target group that spans from 2 to 4 instances for scalability, and spread across 2 subnets for high ava$
  * Database instance using RDS with multi-AZ. the primary instance and the standby instance are in two different AZs for high availability
  * Security groups for the load balancer, target group, and RDS instance

