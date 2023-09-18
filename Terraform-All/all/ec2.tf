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
resource "null_resource" "execute" {
depends_on = [aws_instance.public-instances]
    connection {
        type = "ssh"
        host = aws_instance.foo.public_ip
        user = "ubuntu"
        private_key = "${file("test.pem")}"
    }
    provisioner "file" {
    source      = "anji.sh"
    destination = "/tmp/anji.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/anji.sh",
      "/tmp/anji.sh",
    ]
  }

    provisioner "local-exec" {
    command = "echo '${aws_instance.foo.public_ip}' > instance_ip.txt"
    }


    provisioner "remote-exec" {
        inline = [
        "sleep 60",
        "sudo apt-get update -y",
        "sleep 20",
        "sudo curl https://get.docker.com | bash",
        "docker pull mongo", 
        "sudo docker run -d -p 27017:27017 -e username=mongoadmin -e mongo_password=password -e mango_database=test  mongo",
        "docker ps",
        ]
    }  
}
