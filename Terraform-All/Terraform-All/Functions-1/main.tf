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
	Owner = "Anjaneyulu"
	environment = "${var.environment}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_subnet" "public-subnets" {
    count = "${length(var.public-cidrs)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.public-cidrs, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "${aws_vpc.default.id}-private-subnet-${count.index +1}"
    }
}

resource "aws_subnet" "private-subnets" {
    count = "${length(var.private-cidrs)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.private-cidrs, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"

    tags = {
        Name = "${aws_vpc.default.id}-public-subnet-${count.index +1}"
    }
}

resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

resource "aws_route_table" "terraform-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.natgw.id}"
    }

    tags = {
        Name = "${var.private_Routing_Table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    count = "${length(var.public-cidrs)}"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_route_table_association" "terraform-private" {
    count = "${length(var.private-cidrs)}"
    subnet_id = "${element(aws_subnet.private-subnets.*.id, count.index)}"
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


