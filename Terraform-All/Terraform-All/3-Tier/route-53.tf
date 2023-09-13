resource "aws_route53_zone" "example_zone" {
  name = "anji5413.com"
}

resource "aws_route53_record" "example_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = "www.anji5413.com"
  type    = "A"

  alias {
    name                   = aws_lb.internet_alb.dns_name
    zone_id                = aws_lb.internet_alb.zone_id
    evaluate_target_health = true
  }
}
