resource "null_resource"  "cluster" {
  count = "${var.environment  == "prod" ? 3 : 1}"
  #count = 3 # either you can first count or second count = 3
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
    connection {            #it is remote-exec
        type = "ssh"
        user ="ec2-user"
        private_key = "${file("docker.pem")}"
        host = "${element(aws_instance.public-instances.*.public_ip, count.index)}"
    }
    
  }

#it is remote-exec

  provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/script.sh",
    "sudo bash /tmp/script.sh",
  ]
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("docker.pem")}"
        host = "${element(aws_instance.public-instances.*.public_ip, count.index)}"
    }
  }


  #it is local-exec
  provisioner "local-exec" {
  command = <<EOH
     echo "${element(aws_instance.public-instances.*.public_ip, count.index)}" >> deatils && echo "${element(aws_instance.public-instances.*.private_ip, count.index)}" >> deatils,
    ##it will deails file in your system show the public and private ips  
    EOH
  }

}