resource "aws_instance" "foo" {
    ami           = "ami-02eb7a4783e7e9317" # ap-south-1
    instance_type = "t2.micro"
    availability_zone = "ap-south-1b"
    key_name = "test"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.allow_all.id]
    associate_public_ip_address = true

    tags = {
        Name = "mongo-db"
    }
}

resource "null_resource" "execute" {

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







