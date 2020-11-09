######## VPC ########

resource "aws_vpc" "stripes_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
        Name: "stripes_vpc"
    }
}

######## SUBNETS ########

resource "aws_subnet" "stripes_subnet_public" {
    vpc_id = aws_vpc.stripes_vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

    tags = {
        Name: "stripes_subnet_public"
    }
}

resource "aws_subnet" "stripes_subnet_private" {
    vpc_id = aws_vpc.stripes_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1b"

    tags = {
        Name: "stripes_subnet_private"
    }
}

######## INTERNET GATEWAY ########

resource "aws_internet_gateway" "stripes_igw" {
    vpc_id = aws_vpc.stripes_vpc.id
}

######## ROUTE TABLES ########

resource "aws_route_table" "stripes_public_rtb" {
    vpc_id = aws_vpc.stripes_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.stripes_igw.id
    }

    tags = {
        Name: "stripes_public_rtb"
    }
}

resource "aws_route_table_association" "rtb_publicSubnet_association" {
  subnet_id      = aws_subnet.stripes_subnet_public.id
  route_table_id = aws_route_table.stripes_public_rtb.id
}