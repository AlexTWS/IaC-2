terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

#### AUTO SCALING GROUP ####
resource "aws_launch_configuration" "web" {
  image_id        = "ami-00a205cb8e06c3c4e"
  instance_type   = "t2.micro"
  key_name        = "ssh_key_desktop"
  security_groups = [aws_security_group.target_group.id]
  user_data      = file("webapp.sh")
}

resource "aws_autoscaling_group" "web" {
  desired_capacity     = 2
  min_size             = 2
  max_size             = 4
  vpc_zone_identifier  = [aws_subnet.company_subnet_public_1.id, aws_subnet.company_subnet_public_2.id]
  target_group_arns    = [aws_lb_target_group.target_group.arn]
  launch_configuration = aws_launch_configuration.web.name
}

#### LOAD BALANCER ####
resource "aws_lb" "load_balancer" {
  security_groups    = [aws_security_group.load_balancer.id]
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.company_subnet_public_1.id, aws_subnet.company_subnet_public_2.id]
  # enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "target_group" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.company_vpc.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

output "lb_address" {
  description = "Load balancer DNS name"
  value = aws_lb.load_balancer.dns_name
}