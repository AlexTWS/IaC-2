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

resource "aws_instance" "grav" {
  ami             = var.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web.id, aws_security_group.ssh.id]
  user_data       = file("user_data.sh")
  subnet_id       = aws_subnet.subnet.id
  key_name = var.key_name
  tags = {
    "Name" = "Grav website"
  }
}

output "Address" {
  value = aws_instance.grav.public_dns
}
