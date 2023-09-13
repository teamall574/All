resource "aws_instance" "demo-server" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = "dpp"
    //security_groups = [ "demo-sg" ]
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    subnet_id = aws_subnet.dpp-public-subnet-01.id 
    user_data = filebase64("../EKS/vpc/anji.sh")
//    for_each = toset(["jenkins-master", "build-slave", "ansible"]) if you use this this will creat the 3 instances 
    tags = {
     Name = "${each.key}"
   }
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
