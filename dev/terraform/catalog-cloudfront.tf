########################
## Cloudfront Catalog With Domain
resource "aws_cloudfront_distribution" "cf_distribution_catalog" {
  count = var.catalog_domain_name == null ? 0 : 1
  # This points to s3
  origin {
    domain_name = aws_s3_bucket.s3_static_files.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_static_files.id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    # TODO: re-enable and ensure builds use app_version
    origin_path = "/catalog/latest"
  }

  enabled         = true
  is_ipv6_enabled = true
  # TODO: figure out if this removes the need for cloudfront function
  default_root_object = "pages.json"

  aliases = [var.catalog_domain_name]

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/404.html"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    # function_association {
    #   event_type   = "viewer-request"
    #   function_arn = aws_cloudfront_function.rewrite_uri_react.arn
    # }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.ssl_certificate[0].arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "dev"
  }
}

# TODO: move to new file
resource "null_resource" "s3_distribution_cache_catalog" {
  count = var.catalog_domain_name == null ? 0 : 1
  depends_on = [
    aws_cloudfront_distribution.cf_distribution_catalog[0]
  ]

  # invalidate the cloudfront distribution
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cf_distribution_catalog[0].id} --paths \"/*\""
  }

  # tag with a timestamp for cachebusting
  triggers = {
    always_run = timestamp()
  }
}

########################
## Cloudfront Catalog No Domain
resource "aws_cloudfront_distribution" "cf_distribution_catalog_nodom" {
  count = var.catalog_domain_name == null ? 1 : 0
  # This points to s3
  origin {
    domain_name = aws_s3_bucket.s3_static_files.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_static_files.id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    # TODO: re-enable and ensure builds use app_version
    origin_path = "/catalog/latest"
  }

  enabled         = true
  is_ipv6_enabled = true
  # TODO: figure out if this removes the need for cloudfront function
  default_root_object = "pages.json"

  aliases = [var.catalog_domain_name]

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 200
    response_page_path    = "/404.html"
  }


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }

      headers = ["Origin"]
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    # function_association {
    #   event_type   = "viewer-request"
    #   function_arn = aws_cloudfront_function.rewrite_uri_react.arn
    # }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "dev"
  }
}

# TODO: move to new file
resource "null_resource" "s3_distribution_cache_catalog_nodom" {
  count = var.catalog_domain_name == null ? 1 : 0
  depends_on = [
    aws_cloudfront_distribution.cf_distribution_catalog_nodom[0]
  ]

  # invalidate the cloudfront distribution
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cf_distribution_catalog_nodom[0].id} --paths \"/*\""
  }

  # tag with a timestamp for cachebusting
  triggers = {
    always_run = timestamp()
  }
}