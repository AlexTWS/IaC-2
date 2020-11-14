# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# SUBNETS (2 PUBLIC SUBNETS AND 2 PRIVATE ONES)
resource "aws_subnet" "sub_public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sub_public_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_a
}

resource "aws_subnet" "sub_public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sub_public_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_b
}

resource "aws_subnet" "sub_private_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sub_private_1_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.az_a
}

resource "aws_subnet" "sub_private_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.sub_private_2_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.az_b
}

# ROUTE TABLE
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  route = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }]
}

resource "aws_route_table_association" "rtb_to_sub_public_1" {
  route_table_id = aws_route_table.rtb.id
  subnet_id      = aws_subnet.sub_public_1.id
}

resource "aws_route_table_association" "rtb_to_sub_public_2" {
  route_table_id = aws_route_table.rtb.id
  subnet_id      = aws_subnet.sub_public_2.id
}
