resource "aws_auto_scaling_group" "anji-auto-scaling-group" {
  name                 = "anji-auto-scaling-group"
  launch_template {
    id      = aws_launch_template.anji-launch-template.id
    version = "$Latest"
  }
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  target_group_arns    = [aws_lb_target_group.app-target.arn]
  vpc_zone_identifier = [aws_subnet.app-private_subnet_az1.id, aws_subnet.app-private_subnet_az2.id]
}

resource "aws_lb_target_group" "example" {
  name     = "anji-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id

  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }
}