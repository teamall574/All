resource "aws_lb" "internal_alb" {
  name               = "internal-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [aws_subnet.app-private_subnet_az1.id, aws_subnet.app-private_subnet_az2.id]
  security_groups   = [aws_security_group.internal_sg.id]

  enable_deletion_protection = false

  enable_http2 = true

  enable_deletion_protection = false

  enable_http2 = true

  enable_deletion_protection = false
}
output "internal_lb_endpoint" {
  value = aws_lb.internal_lb.dns_name
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

resource "aws_lb_listener_rule" "example" {
  listener_arn = aws_lb_listener.alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-target.arn
  }
}




