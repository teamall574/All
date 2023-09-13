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
    provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/script",
      "echo 'Your script content here' > /tmp/script/anji.sh",  # Replace with the actual content of anji.sh
      "chmod +x /tmp/script/anji.sh",
      "/tmp/script/anji.sh",
    ]

    connection {
        type = "ssh"
        host = aws_instance.foo.public_ip
        user = "ubuntu"
        private_key = "${file("test.pem")}"
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
    depends_on = [aws_instance.foo]
   }  
}
