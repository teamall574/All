resource "aws_lb_target_group" "web-target" {
  name     = "anji-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }
}

