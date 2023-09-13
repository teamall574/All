resource "aws_instance" "public-Instances" {
    count = "${var.environment == "prod" ? 3 : 1}"
    ami = "${lookup(var.amis, var.aws_region, "ap-south-1")}"
    instance_type = var.env == "PROD" ? "t3.large" : "t2.micro"   ##if the env == prod it will deploy t3.large instance
    key_name = "chefkeypair"
    user_data = file("apache-install.sh")
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}]
    associate_public_ip_address = true
    user_data = <<-EOF
              #!/bin/bash
              curl -fsSL https://raw.githubusercontent.com/your-repo/anji.sh | bash
              EOF
    tags = {
        Name = "public-server-${count.index+1}"
    }
}
resource "aws_instance" "private-instances" {
    count = "${var.environment == "prod" ? 3 : 1}"
    ami = "${lookup(var.amis, var.aws_region, "ap-south-1")}"
    instance_type = "t2.micro"
    key_name = "chefkeypair"
    subnet_id = "${element(aws_subnet.private-subnets.*.id, count.index}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}]
    #associate_public_ip_address = true
    tags = {
        Name = "private-server-${count.index+1}"
    }
}
