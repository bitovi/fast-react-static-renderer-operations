# This is the s3 bucket that will house the static sites
resource "aws_s3_bucket" "s3_static_files" {
  bucket                  = var.bucket_name
  acl                     = "public-read"

  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })
  tags = {
    Name                      = var.bucket_name
    terraform                 = "true"
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "global-tools"
  }

  # Depricated warning; https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    # allowed_origins = ["https://www.${var.domain_name}"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}