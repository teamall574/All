resource "aws_eip" "eipnatgw" {
    vpc = true
}

resource "aws_nat_gateway" "natgw" {
    allocation_id = "${aws_eip.eipnatgw.id}"
    subnet_id = "${aws_subnet.public-subnets.0.id}"
}