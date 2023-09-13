resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }
}

resource "aws_route_table_association" "public_subnet_rt" {
  subnet_id      = [aws_subnet.public_subnet_az1.id,aws_subnet.public_subnet_az2.id]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "app_private" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_az1.id}"
    }
}

resource "aws_route_table_association" "app_private_subnet_rt" {
  subnet_id      = [aws_subnet.app-private_subnet_az1.id, aws_subnet.db-private_subnet_az1.id]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "db_private" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.nat_az2.id}"
    }
}

resource "aws_route_table_association" "db_private_subnet_rt" {
  subnet_id      = [aws_subnet.app-private_subnet_az2.id,aws_subnet.db-private_subnet_az2.id]
  route_table_id = aws_route_table.public.id
}