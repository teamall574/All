resource "aws_auto_scaling_group" "web-auto-scaling-group" {
  name                 = "web-auto-scaling-group"
  launch_template {
    id      = aws_launch_template.web-launch-template.id
    version = "$Latest"
  }
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  target_group_arns    = [aws_lb_target_group.web-target.arn]
  vpc_zone_identifier = [aws_subnet.app-private_subnet_az1.id, aws_subnet.app-private_subnet_az2.id]
}