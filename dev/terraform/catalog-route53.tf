resource "aws_route53_record" "catalog-dns" {
  count   = var.catalog_domain_name == null ? 0 : 1
  zone_id = var.hosted_zone_id
  name    = var.catalog_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution_catalog.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_catalog.hosted_zone_id
    evaluate_target_health = false
  }
}