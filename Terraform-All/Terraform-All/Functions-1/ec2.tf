resource "aws_instance" "public-instances" {
    count = 2
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    key_name = "chefkeypair"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true

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
