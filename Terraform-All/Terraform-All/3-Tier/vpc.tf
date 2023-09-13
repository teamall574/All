resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "app-private_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.10.0/24"
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "app-private_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.20.0/24"
  availability_zone       = "us-east-1b"
}

resource "aws_subnet" "db-private_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.100.0/24"
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "db-private_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.110.0/24"
  availability_zone       = "us-east-1b"
}  


