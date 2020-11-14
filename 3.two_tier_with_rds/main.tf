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
  region  = var.region
}

# ----------------------- INTERNET GATEWAY ----------------------- #
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# ------------------------ LOAD BALANCER ------------------------- #
resource "aws_lb" "lb" {
  internal                         = false
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  subnets                          = [aws_subnet.sub_public_1.id, aws_subnet.sub_public_2.id]
  security_groups                  = [aws_security_group.lb.id]
}

resource "aws_lb_target_group" "web" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# ---------------------- AUTO SCALING GROUP ---------------------- #
resource "aws_launch_configuration" "web" {
  image_id        = var.image_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.web.id]
  #user_data = "value"
}

resource "aws_autoscaling_group" "web" {
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.web
  vpc_zone_identifier  = [aws_subnet.sub_public_1.id, aws_subnet.sub_public_2.id]
  target_group_arns    = [aws_lb_target_group.web.arn]
}

# ------------------ RELATIONAL DATABASE SERVICE ----------------- #
resource "aws_db_instance" "name" {
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  username               = "root"
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_subnet.sub_private_1
  multi_az               = true
}
