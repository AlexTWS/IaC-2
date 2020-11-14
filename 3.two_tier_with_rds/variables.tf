# REGION
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# SUBNETS
variable "sub_public_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "sub_public_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "sub_private_1_cidr" {
  type    = string
  default = "10.0.3.0/24"
}

variable "sub_private_2_cidr" {
  type    = string
  default = "10.0.4.0/24"
}

# AVAILABILITY ZONES
variable "az_a" {
  type    = string
  default = "eu-central-1a"
}

variable "az_b" {
  type    = string
  default = "eu-central-1b"
}

variable "image_id" {
  description = "Ubuntu 20.04 LTS Image"
  type        = string
  default     = "ami-0502e817a62226e03"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "ssh_key_desktop"
}

variable "db_password" {
  type    = string
  default = "example_password"
}
