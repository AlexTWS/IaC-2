# VPC
resource "aws_vpc" "company_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}

# SUBNETS
resource "aws_subnet" "company_subnet_public_1" {
  vpc_id                  = aws_vpc.company_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"
}

resource "aws_subnet" "company_subnet_public_2" {
  vpc_id                  = aws_vpc.company_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1b"
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "company_igw" {
  vpc_id = aws_vpc.company_vpc.id
}

# ROUTE TABLE FOR PUBLIC SUBNET
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.company_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.company_igw.id
  }
}

resource "aws_route_table_association" "rtb_to_public_subnet_1" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.company_subnet_public_1.id
}

resource "aws_route_table_association" "rtb_to_public_subnet_2" {
  route_table_id = aws_route_table.rtb_public.id
  subnet_id      = aws_subnet.company_subnet_public_2.id
}
