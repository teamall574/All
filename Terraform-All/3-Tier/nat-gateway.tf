resource "aws_nat_gateway" "nat_az1" {
  subnet_id     = aws_subnet.public_subnet_az1.id
  allocation_id = aws_eip.nat_eip_az1.id
}

resource "aws_nat_gateway" "nat_az2" {
  subnet_id     = aws_subnet.public_subnet_az2.id
  allocation_id = aws_eip.nat_eip_az2.id
}

resource "aws_eip" "nat_eip_az1" {
  vpc = true
}

resource "aws_eip" "nat_eip_az2" {
  vpc = true
}



















