resource "aws_vpc" "stripes_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags {
        Name = "stripes_vpc"
    }
}

resource "aws_subnet" "stripes_subnet_public_1" {
    vpc_id = "${aws_vpc.stripes_vpc.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

    tags {
        Name = "stripes_subnet_public_1"
    }
}