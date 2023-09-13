data "aws_ami" "amazon-linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm"]
    }
}

output "ami-ID" {
    value = data.aws_ami.amazon-linux.id
}