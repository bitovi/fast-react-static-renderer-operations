

resource "aws_route53_record" "catalog-dns" {
  zone_id = var.hosted_zone_id
  name    = var.catalog_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.catalog_domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}