locals {
    ingress_rules = [
        {
            description = "SSH from my status"
            port = "22"
        },
        {
            description = "SSH from my status"
            port = "80"
        },
        {
            description = "SSH from my status"
            port = "443"
        }
    ]

}
resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh_http_https"
    description = "Allow SSH HTTP HTTPS inbound traffic"
    vpc_id = "vpc-65ihhkhjkgs"

    dynamic "ingress" {
        for_each = local.ingress
        content {
            description =  ingress.value.description
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocal = "tcp"
            
        }
      
    }

}