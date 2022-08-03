

resource "aws_route53_record" "root-react" {
  count   = var.hosted_zone_id == null ? 0 : 1
  zone_id = var.hosted_zone_id
  name    = var.subdomain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_distribution[0].domain_name
    zone_id                = aws_cloudfront_distribution.cf_distribution[0].hosted_zone_id
    evaluate_target_health = false
  }
}