# SSL Certificate
resource "aws_acm_certificate" "ssl_certificate" {
  count                     = var.domain_name == null ? 0 : 1
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  # validation_method         = "EMAIL"
  validation_method = "DNS"

  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count           = var.domain_name == null ? 0 : 1
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.ssl_certificate[0].domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.ssl_certificate[0].domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.ssl_certificate[0].domain_validation_options)[0].resource_record_type
  zone_id         = var.hosted_zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  count                   = var.domain_name == null ? 0 : 1
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.ssl_certificate[0].arn
  validation_record_fqdns = [aws_route53_record.cert_validation[0].fqdn]
}