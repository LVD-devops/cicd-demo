#resource "aws_route53_zone" "main" {
#  name = "local.com"
#}
#
#resource "aws_route53_record" "www" {
#  zone_id = aws_route53_zone.main.zone_id
#  name    = "www.local.com"
#  type    = "A"
#
#  alias {
#    name                   = aws_lb.main.dns_name
#    zone_id                = aws_lb.main.zone_id
#    evaluate_target_health = false
#  }
#}