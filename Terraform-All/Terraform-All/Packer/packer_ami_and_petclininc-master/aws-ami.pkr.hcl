#If you have your default VPC available then use it. 

# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


# which ami to use as the base and where to save it


source "amazon-ebs" "Amazon_ami_image" {
  region                      = "us-east-2"
  ami_name                    = "ami-build-with-packer-{{timestamp}}"
  instance_type               = "t2.micro"
  source_ami                  = "ami-0d1c47ab964ae2b87"
  ssh_username                = "ec2-user"
  associate_public_ip_address = true
  subnet_id                   = "subnet-040a331d4c3bf167e"
  security_group_id           = "sg-0073829f31cd7a8a4" //This secuirty group should have port 22 to be open so that packer can ssh into the instance and install necessary softwares
  #ami_users       = ["AWS Account ID"]
  ami_regions = [
    "us-east-2"
  ]
}

# what to install, configure and file to copy/execute
build {
  name = "hq-packer"
  sources = [
    "amazon-ebs.Amazon_ami_image"
  ]
  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}

