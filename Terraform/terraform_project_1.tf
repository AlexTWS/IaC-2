terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 2.70"
        }
    }
}

provider "aws" {
    profile = "default"
    region = "eu-central-1"
}

resource "aws_instance" "example" {
    ami = "ami-00a205cb8e06c3c4e"
    key_name = "ssh_key_desktop"
    instance_type = "t2.micro"
    tags = {
        Name: "minion"
        project: "terraform"
    }
    security_groups = [ "SSH" ]
}