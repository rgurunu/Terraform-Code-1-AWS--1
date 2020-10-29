# Internet VPC
resource "aws_vpc" "sush-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "sush-vpc"
  }
}

# Subnets
resource "aws_subnet" "sush-public-1" {
  vpc_id                  = aws_vpc.sush-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "sush-public-1"
  }
}

resource "aws_subnet" "sush-public-2" {
  vpc_id                  = aws_vpc.sush-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "sush-public-2"
  }
}


# Internet GW
resource "aws_internet_gateway" "sush-gw" {
  vpc_id = aws_vpc.sush-vpc.id

  tags = {
    Name = "sush-vpc"
  }
}

# route tables
resource "aws_route_table" "sush-public" {
  vpc_id = aws_vpc.sush-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sush-gw.id
  }

  tags = {
    Name = "sush-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "sush-public-1-a" {
  subnet_id      = aws_subnet.sush-public-1.id
  route_table_id = aws_route_table.sush-public.id
}

resource "aws_route_table_association" "sush-public-2-a" {
  subnet_id      = aws_subnet.sush-public-2.id
  route_table_id = aws_route_table.sush-public.id
}
