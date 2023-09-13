resource "aws_launch_template" "anji-launch-template" {
  name_prefix      = "anji-launch-template-"
  image_id         = "ami-12345678"  # Replace with your custom AMI ID
  instance_type    = "t3.medium"
  key_name         = "anji-keypair"
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  iam_instance_profile {
    name = "anji"  # Replace with your IAM role name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100
      volume_type = "gp2"
    }
  }
}