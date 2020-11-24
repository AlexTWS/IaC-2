######## VPC ########

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name : "grav_vpc"
  }
}

######## SUBNET ########

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"

  tags = {
    Name : "grav_subnet"
  }
}

######## INTERNET GATEWAY ########

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

######## ROUTE TABLES ########

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name : "grav_internet"
  }
}

resource "aws_route_table_association" "rtb_subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.internet.id
}
