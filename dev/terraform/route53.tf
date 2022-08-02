

resource "aws_route53_record" "root-react" {
  count   = var.hosted_zone_id ? 1 : 0
  zone_id = var.hosted_zone_id
  name    = var.subdomain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}