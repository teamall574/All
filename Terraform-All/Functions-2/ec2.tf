resource "aws_instance" "public-instances" {
    count = "${var.environment  == "prod" ? 3 : 1}"     # if production environmet=prod it will deploy 3 otherwise it will deploy 1 only
    ami = "${lookup(var.amis, var.aws_region, "us-east-1")}"      #it will select the region based ami
    instance_type = "t2.micro"
    key_name = "chefkeypair"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true
   
    tags = {
        Name = "public-server-${count.index+1}"

    }
}    
              ##it will create 3 if environment=prod

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
