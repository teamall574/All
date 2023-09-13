terraform {
  required_providers {
    mycloud = {
      source  = "mycorp/mycloud"
      version = "~> 1.0"
      configuration_aliases = [ mycloud.alternate ]
    }
  }
}
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
    }
	depends_on = {
aws_vpc.default
}
}

resource "aws_subnet" "public-subnets" {
    count = "${var.environment == "prod" ? 3 : 2}"
    vpc_id = "$element{aws_vpc.default.id}"
    cidr_block = "${element(var.public-cidrs, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "$element{aws_vpc.default.tags.name}-public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private-subnets" {
    count = "${var.environment == "prod" ? 3 : 2}"
    vpc_id = "$element{aws_vpc.default.id}"
    cidr_block = "${element(var.private-cidrs, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "$element{aws_vpc.default.tags.name}-private-subnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.public_routing_Table}"
    }
}

resource "aws_route_table" "terraform-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }

    tags = {
        Name = "${var.private_routing_table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    count = "${var.environment == "prod" ? 3 : 1}"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}
resource "aws_route_table_association" "terraform-private" {
    count = "${var.environment == "prod" ? 3 : 1}"
    subnet_id = "${element(aws_subnet.private-subnets.id, count.index)}"
    route_table_id = "${aws_route_table.terraform-private.id}"
}
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"
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
}
