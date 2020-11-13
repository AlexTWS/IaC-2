######## VPC ########

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name : "stripes_vpc"
  }
}

######## SUBNETS ########

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"

  tags = {
    Name : "subnet_public"
  }
}

######## INTERNET GATEWAY ########

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

######## ROUTE TABLES ########

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.my_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name : "rtb_public"
  }
}

resource "aws_route_table_association" "rtb_to_public_subnet_association" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}