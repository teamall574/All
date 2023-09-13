provider "aws" {
    access_key ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    region = "ap-south-1"
}

resource "aws_vpc" "main" {
    cidr_block = "10.1.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "anji"
    }
    
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.1.0/24"

    tags = {
        Name = "private-subnet"
    }

}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.1.2.0/24"

    tags = {
        Name = "public-subnet"
    }

}

resource "aws_internet_gateway" "automated-igw" {
    vpc_id = aws_vpc.main.id 

    tags = {
        Name ="internet-gateway"
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.automated-igw.id 
    }
    
    tags = {
        Name = "public-route"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "test-security"
    }
}



















