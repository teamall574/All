resource "aws_eip" "eip-nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
    allocation_id = "${aws_eip.eip-nat.id}"
    subnet_id = "{aws_subnet.public-subnets.0.id}"
}
