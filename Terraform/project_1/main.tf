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

resource "aws_security_group" "web_app" {
    name = "web_app"
    description = "allow HTTP port"
    vpc_id = aws_vpc.stripes_vpc.id

    ingress {
        description = "Allow HTTP"
        from_port = 80
        to_port = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web_app"
    }
}

resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "allow port 22"
    vpc_id = aws_vpc.stripes_vpc.id

    ingress {
        description = "Allow SSH"
        from_port = 22
        to_port = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ssh"
    }
}

resource "aws_instance" "web_app" {
    ami = "ami-00a205cb8e06c3c4e"
    key_name = "ssh_key_desktop"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.stripes_subnet_public.id
    security_groups = [ "ssh", "web_app" ]
        tags = {
        Name: "web_app"
        project: "terraform"
    }
    user_data = file("webapp.sh")
}